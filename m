From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] trivial treewide: Convert dev_set_uevent_suppress
 argument to bool
Date: Fri, 02 Sep 2016 09:49:29 -0700
Message-ID: <1472834969.6758.52.camel@perches.com>
References: <699402ce4c488995b4ddabff0f3b262851cf56ac.1472760613.git.joe@perches.com>
         <BLUPR02MB1683CF8A399E613B8C209C3B81E50@BLUPR02MB1683.namprd02.prod.outlook.com>
         <1472777516.4176.149.camel@perches.com>
         <BLUPR02MB1683E6A75F29015CBCAD804D81E50@BLUPR02MB1683.namprd02.prod.outlook.com>
         <1472830862.6758.7.camel@perches.com>
         <7405780b-3dcd-3c6a-9268-3fac6f3a7b3f@sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <7405780b-3dcd-3c6a-9268-3fac6f3a7b3f@sandisk.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-acpi/>
List-Post: <mailto:linux-acpi@vger.kernel.org>
To: Bart Van Assche <bart.vanassche@sandisk.com>, Jens Axboe <axboe@kernel.dk>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Peter Oberparleiter <oberpar@linux.vnet.ibm.com>, Miklos Szeredi <miklos@szeredi.hu>, Jiri Kosina <trivial@kernel.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Fri, 2016-09-02 at 08:59 -0700, Bart Van Assche wrote:
> How about the following:
>=20
> dev_set_uevent_suppress() expects a boolean as second argument. Make=A0
> this clear by passing true/false instead of 1/0 as the second
> argument.

dev_set_uevent_suppress()=A0doesn't currently expect a boolean.

The patch changes the function definition argument from int to bool
and also changes all callers of the function to true/false from 1/0.
