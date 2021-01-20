Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 20 Jan 2021 14:42:08 +0100
From: Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH 2/2] s390: mm: Fix secure storage access exception
 handling
Message-ID: <20210120134208.GC8202@osiris>
References: <20210119100402.84734-1-frankja@linux.ibm.com>
 <20210119100402.84734-3-frankja@linux.ibm.com>
 <3e1978c6-4462-1de6-e1aa-e664ffa633c1@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e1978c6-4462-1de6-e1aa-e664ffa633c1@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Janosch Frank <frankja@linux.ibm.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, thuth@redhat.com, david@redhat.com, imbrenda@linux.ibm.com, cohuck@redhat.com, linux-s390@vger.kernel.org, gor@linux.ibm.com, mihajlov@linux.ibm.com

On Tue, Jan 19, 2021 at 11:25:01AM +0100, Christian Borntraeger wrote:
> > +		if (user_mode(regs)) {
> > +			send_sig(SIGSEGV, current, 0);
> > +			return;
> > +		} else
> > +			panic("Unexpected PGM 0x3d with TEID bit 61=0");
> 
> use BUG instead of panic? That would kill this process, but it allows
> people to maybe save unaffected data.

It would kill the process, and most likely lead to deadlock'ed
system. But with all the "good" debug information being lost, which
wouldn't be the case with panic().
I really don't think this is a good idea.
