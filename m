From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] trivial treewide: Convert dev_set_uevent_suppress
 argument to bool
Date: Thu, 01 Sep 2016 17:51:56 -0700
Message-ID: <1472777516.4176.149.camel@perches.com>
References: <699402ce4c488995b4ddabff0f3b262851cf56ac.1472760613.git.joe@perches.com>
         <BLUPR02MB1683CF8A399E613B8C209C3B81E50@BLUPR02MB1683.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-block-owner@vger.kernel.org>
In-Reply-To: <BLUPR02MB1683CF8A399E613B8C209C3B81E50@BLUPR02MB1683.namprd02.prod.outlook.com>
Sender: linux-block-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-acpi/>
List-Post: <mailto:linux-acpi@vger.kernel.org>
To: Bart Van Assche <Bart.VanAssche@sandisk.com>, Jens Axboe <axboe@kernel.dk>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Peter Oberparleiter <oberpar@linux.vnet.ibm.com>, Miklos Szeredi <miklos@szeredi.hu>, Jiri Kosina <trivial@kernel.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Fri, 2016-09-02 at 00:47 +0000, Bart Van Assche wrote:
> On 09/01/16 13:11, Joe Perches wrote:
> >=20
> > Assigning an int to a bitfield:1 can lose precision.
> > Change the caller argument uses from 1/0 to true/false.
> Hello Joe,

Hi Bart.

> Can you clarify how assigning 0 or 1 to a one-bit bitfield can cause a=A0
> loss of precision?

There are no existing defects.

Using 1/0 is not a loss of precision, it's just
changing to use bool avoids potential errors and
promotes consistency.

Other uses of this function already use true/false.
