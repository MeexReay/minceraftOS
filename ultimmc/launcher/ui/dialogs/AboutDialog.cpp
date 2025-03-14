/* Copyright 2013-2021 MultiMC Contributors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include "AboutDialog.h"
#include "ui_AboutDialog.h"
#include <QIcon>
#include "Application.h"
#include "BuildConfig.h"

#include <net/NetJob.h>

#include "HoeDown.h"

namespace {
// Credits
// This is a hack, but I can't think of a better way to do this easily without screwing with QTextDocument...
QString getCreditsHtml(QStringList patrons)
{
    QString output;
    QTextStream stream(&output);
    stream.setCodec(QTextCodec::codecForName("UTF-8"));
    stream << "<center>\n";

    stream << "<h3>" << QObject::tr("Original Author", "About Credits") << "</h3>\n";
    stream << "<p>Andrew Okin &lt;<a href='mailto:forkk@forkk.net'>forkk@forkk.net</a>&gt;</p>\n";

    stream << "<h3>" << QObject::tr("Maintainer", "About Credits") << "</h3>\n";
    stream << "<p>Petr Mr&aacute;zek &lt;<a href='mailto:peterix@gmail.com'>peterix@gmail.com</a>&gt;</p>\n";

    // TODO: grab contributors from git history
    /*
    if(!contributors.isEmpty()) {
        stream << "<h3>" << QObject::tr("Contributors", "About Credits") << "</h3>\n";
        for (auto &contributor : contributors)
        {
            stream << "<p>" << contributor << "</p>\n";
        }
    }
    */

    if(!patrons.isEmpty()) {
        stream << "<h3>" << QObject::tr("Patrons", "About Credits") << "</h3>\n";
        for (QString patron : patrons)
        {
            stream << "<p>" << patron << "</p>\n";
        }
    }

    stream << "</center>\n";
    return output;
}

QString getLicenseHtml()
{
    HoeDown hoedown;
    QFile dataFile(":/documents/COPYING.md");
    dataFile.open(QIODevice::ReadOnly);
    QString output = hoedown.process(dataFile.readAll());
    return output;
}

}

AboutDialog::AboutDialog(QWidget *parent) : QDialog(parent), ui(new Ui::AboutDialog)
{
    ui->setupUi(this);

    QString launcherName = BuildConfig.LAUNCHER_NAME;

    setWindowTitle(tr("About %1").arg(launcherName));

    QString chtml = getCreditsHtml(QStringList());
    ui->creditsText->setHtml(chtml);

    QString lhtml = getLicenseHtml();
    ui->licenseText->setHtml(lhtml);

    ui->urlLabel->setOpenExternalLinks(true);

    ui->icon->setPixmap(APPLICATION->getThemedIcon("logo").pixmap(64));
    ui->title->setText(launcherName);

    ui->versionLabel->setText(tr("Version") +": " + BuildConfig.printableVersionString());
    ui->platformLabel->setText(tr("Platform") +": " + BuildConfig.BUILD_PLATFORM);

    if (BuildConfig.VERSION_BUILD >= 0)
        ui->buildNumLabel->setText(tr("Build Number") +": " + QString::number(BuildConfig.VERSION_BUILD));
    else
        ui->buildNumLabel->setVisible(false);

    if (!BuildConfig.VERSION_CHANNEL.isEmpty())
        ui->channelLabel->setText(tr("Channel") +": " + BuildConfig.VERSION_CHANNEL);
    else
        ui->channelLabel->setVisible(false);

    ui->redistributionText->setHtml(tr(
"<p>We keep MultiMC open source because we think it's important to be able to see the source code for a project like this, and we do so using the Apache license.</p>\n"
"<p>Part of the reason for using the Apache license is we don't want people using the &quot;MultiMC&quot; name when redistributing the project. "
"This means people must take the time to go through the source code and remove all references to &quot;MultiMC&quot;, including but not limited to the project "
"icon and the title of windows, (no <b>MultiMC-fork</b> in the title).</p>\n"
"<p>The Apache license covers reasonable use for the name - a mention of the project's origins in the About dialog and the license is acceptable. "
"However, it should be abundantly clear that the project is a fork <b>without</b> implying that you have our blessing.</p>"
    ));

    QString urlText("<html><head/><body><p><a href=\"%1\">%1</a></p></body></html>");
    ui->urlLabel->setText(urlText.arg(BuildConfig.LAUNCHER_GIT));

    QString copyText("© 2012-2021 %1");
    ui->copyLabel->setText(copyText.arg(BuildConfig.LAUNCHER_COPYRIGHT));

    connect(ui->closeButton, SIGNAL(clicked()), SLOT(close()));

    connect(ui->aboutQt, &QPushButton::clicked, &QApplication::aboutQt);

    loadPatronList();
}

AboutDialog::~AboutDialog()
{
    delete ui;
}

void AboutDialog::loadPatronList()
{
    netJob = new NetJob("Patreon Patron List", APPLICATION->network());
    netJob->addNetAction(Net::Download::makeByteArray(QUrl("https://files.multimc.org/patrons.txt"), &dataSink));
    connect(netJob.get(), &NetJob::succeeded, this, &AboutDialog::patronListLoaded);
    netJob->start();
}

void AboutDialog::patronListLoaded()
{
    QString patronListStr(dataSink);
    dataSink.clear();
    QString html = getCreditsHtml(patronListStr.split("\n", QString::SkipEmptyParts));
    ui->creditsText->setHtml(html);
}

