Return-Path: <linux-fsdevel-owner@vger.kernel.org>
From: Huaisheng HS1 Ye <yehs1@lenovo.com>
Subject: RE: [External]  Re: [PATCH 0/5] Do not request a pointer kaddr when
 not required
Date: Tue, 24 Jul 2018 15:41:22 +0000
Message-ID: <TY2PR03MB33437169EF0F111DDF9C6A4A92550@TY2PR03MB3343.apcprd03.prod.outlook.com>
References: <20180724084510.6104-1-yehs2007@zoho.com>
 <20180724145013.GA19466@linux.intel.com>
In-Reply-To: <20180724145013.GA19466@linux.intel.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-fsdevel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-fsdevel/>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
To: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "dan.j.williams@intel.com" <dan.j.williams@intel.com>, "willy@infradead.org" <willy@infradead.org>, "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, "dave.jiang@intel.com" <dave.jiang@intel.com>, "schwidefsky@de.ibm.com" <schwidefsky@de.ibm.com>, "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "martin.petersen@oracle.com" <martin.petersen@oracle.com>, "axboe@kernel.dk" <axboe@kernel.dk>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "bart.vanassche@wdc.com" <bart.vanassche@wdc.com>, "jack@suse.cz" <jack@suse.cz>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, NingTing Cheng <chengnt@lenovo.com>, Huaisheng Ye <yehs2007@zoho.com>
List-ID: <linux-s390.vger.kernel.org>

From: Ross Zwisler <ross.zwisler@linux.intel.com>
Sent: Tuesday, July 24, 2018 10:50 PM
> > Some functions within fs/dax and dax/super don't need to get kaddr from
> > direct_access. Assigning NULL to kaddr to ->direct_access() is more
> > straightforward and simple than offering a useless local pointer.
> >
> > So all direct_access() need to check the validity of second rank pointe=
r
> > kaddr for NULL assignment. If kaddr equals to NULL, it doesn't need to
> > calculate its value.
> >
> > * This series are supplement to [PATCH v2 00/14]mm: Asynchronous +
> >   multithreaded memmap init for ZONE_DEVICE. [1]
> >
> > [1]: https://lkml.org/lkml/2018/7/16/828
>=20
> This whole series looks good to me.  Just a few comments:
>=20
> 1) Does this series actually depend on the "Asynchronous multithreaded mm=
ap
> init for ZONE_DEVICE" series from Dan?  It seems totally independent to m=
e?
> I reviewed yours by applying to linux/master, which worked fine.  I ask
> because Dan's series has been delayed to after v4.19, and if yours isn't
> actually dependent it could possibly go in sooner.

This series doesn't depend on Dan's 'Asynchronous multithreaded mmap init
for ZONE_DEVICE'. For the part as pfn, which overlaps Dan's original series=
.
Because I post them earlier than Dan's, Dan generously dropped the overlapp=
ing
from his series and adopted mine to the series of 'Asynchronous multithread=
ed'.
It is very thankful.

I knew Dan's series would be delayed, I can resend the series, both kaddr a=
nd pfn,
for faster merging to mainline.

> 2) I agree with Christian's comment that the changelogs could be improved
> slightly.  Remember that the goal of the changelog isn't to describe *wha=
t*
> the code is doing, but *why*.  We can read that the code now checks if 'k=
addr'
> is NULL, and if so we don't calculate it.  It's useful to say that caller=
s may
> have no need for 'kaddr', so this patch is prep for allowing them to pass=
 in
> NULL instead of having to pass in a pointer that they then just throw awa=
y.

Thanks for advice. I will follow your suggestion during next submission.

> 3) I think you should make one more change to kill the unused 'dummy_addr=
'
> variable in persistent_memory_claim().  That was the one last case of a d=
ummy
> 'kaddr' type variable that I could find.

Yes, you are right. I haven't updated my code base to latest mainline, so c=
ouldn't
notice it. It seems there is a new created file here as dm-writecache.c.
Thanks for hints.

Cheers,
Huaisheng Ye
