From: Eugene Syromiatnikov <esyr@redhat.com>
Date: Mon, 22 Jan 2018 13:29:47 +0000
Subject: Re: [strace PATCH 04/12] Introduce s390_sthyi system call decoder
Message-Id: <20180122132947.GD18640@asgard.redhat.com>
In-Reply-To: <20180122131643.GB4806@osiris>
References: <20180122131643.GB4806@osiris>
To: linux-s390@vger.kernel.org, strace@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, Jan 22, 2018 at 02:16:43PM +0100, Heiko Carstens wrote:
> On Thu, Jan 18, 2018 at 07:16:44AM +0100, Eugene Syromyatnikov wrote:
> > +static void
> > +print_sthyi_hypervisor(struct tcb *tcp, struct sthyi_hypervisor *hdr,
> > +		       uint16_t size, int num, bool mt)
> > +{
> > +	CHECK_SIZE(hdr, size, "hypervisor %d structure", num);
> > +
> > +	tprintf("/* hypervisor %d */ ", num);
> > +	PRINT_FIELD_0X("{", *hdr, infyflg1);
> > +	if (!abbrev(tcp) && hdr->infyflg1)
> > +		tprintf_comment("%s%s%s%s%#.0x%s",
> > +			hdr->infyflg1 & 0x80 ?
> > +				"0x80 - guest CPU usage had limiting is using "
> > +				"the consumption method" : "",
> > +			(hdr->infyflg1 & 0x80) && (hdr->infyflg1 & 0x40) ?
> > +				", " : "",
> > +			hdr->infyflg1 & 0x40 ?
> > +				"0x40 -  LIMITHARD caps use prorated core time "
>                                        ^^
> Here you have two whitespace characters (instead of one) which cause the
> s390_sthyi-v test to fail.

Uhh, sorry, I've overlooked it (on the other side, that's what are tests
for).  I'll resend the patch.  Thank you for the report!
