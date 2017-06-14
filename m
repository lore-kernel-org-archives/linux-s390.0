Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <1497437132.18751.45.camel@perches.com>
Subject: Re: [PATCH] checkpatch: HLIST_HEAD is also declaration
From: Joe Perches <joe@perches.com>
Date: Wed, 14 Jun 2017 03:45:32 -0700
In-Reply-To: <1497436908.18751.43.camel@perches.com>
References: <20170614101626.81494-1-maier@linux.vnet.ibm.com>
         <1497436908.18751.43.camel@perches.com>
Content-Type: text/plain; charset="iso-8859-1"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Steffen Maier <maier@linux.vnet.ibm.com>, Andy Whitcroft <apw@canonical.com>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

(drat, accidentally hit ctrl-enter)

On Wed, 2017-06-14 at 03:41 -0700, Joe Perches wrote:
> On Wed, 2017-06-14 at 12:16 +0200, Steffen Maier wrote:
> > Fixes the following false warning:
> >=20
> >     WARNING: Missing a blank line after declarations
> >     #71: FILE: drivers/s390/scsi/zfcp_fsf.c:422:
> >     +	struct hlist_node *tmp;
> >     +	HLIST_HEAD(remove_queue);
> >=20
> > Signed-off-by: Steffen Maier <maier@linux.vnet.ibm.com>

OK, thanks but what about the other defines of
LLIST_HEAD,=A0PLIST_HEAD, SLIST_HEAD ?
