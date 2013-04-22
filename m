From: Heiko Carstens <heiko.carstens@de.ibm.com>
Date: Mon, 22 Apr 2013 12:20:15 +0000
Subject: Re: struct statfs::f_type too small to carry magic values
Message-Id: <20130422122015.GB4192@osiris>
In-Reply-To: <20130422121901.GA4192@osiris>
References: <20130422121901.GA4192@osiris>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, Apr 19, 2013 at 02:23:59PM +0200, Kay Sievers wrote:
> On Fri, Apr 19, 2013 at 2:16 PM, Martin Schwidefsky
> <schwidefsky@de.ibm.com> wrote:
> > On Fri, 19 Apr 2013 13:44:53 +0200 Kay Sievers <kay@vrfy.org> wrote:
> >> It's pretty confusing to sort out such issues in userspace, and it
> >> would be nice if it could be fixed to work without weird casting.
> >
> > Well, the easiest fix seem to be to convert the "int f_type" to an
> > "unsigned int f_type".
> 
> That would be nice if that is possible, yeah.

...and the patch below for glibc:
