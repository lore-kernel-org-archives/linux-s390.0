From: Bart Van Assche <Bart.VanAssche@sandisk.com>
Subject: Re: [PATCH] trivial treewide: Convert dev_set_uevent_suppress
 argument to bool
Date: Fri, 2 Sep 2016 00:47:30 +0000
Message-ID: <BLUPR02MB1683CF8A399E613B8C209C3B81E50@BLUPR02MB1683.namprd02.prod.outlook.com>
References: <699402ce4c488995b4ddabff0f3b262851cf56ac.1472760613.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-block-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-acpi/>
List-Post: <mailto:linux-acpi@vger.kernel.org>
To: Joe Perches <joe@perches.com>, Jens Axboe <axboe@kernel.dk>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Peter Oberparleiter <oberpar@linux.vnet.ibm.com>, Miklos Szeredi <miklos@szeredi.hu>, Jiri Kosina <trivial@kernel.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On 09/01/16 13:11, Joe Perches wrote:=0A=
> Assigning an int to a bitfield:1 can lose precision.=0A=
> Change the caller argument uses from 1/0 to true/false.=0A=
=0A=
Hello Joe,=0A=
=0A=
Can you clarify how assigning 0 or 1 to a one-bit bitfield can cause a =0A=
loss of precision?=0A=
=0A=
Thanks,=0A=
=0A=
Bart.=0A=
=0A=
