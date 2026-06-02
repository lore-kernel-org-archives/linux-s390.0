Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0469D175A79;
	Tue,  2 Jun 2026 21:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780435991; cv=none; b=LS8Ekhtdu+0GiKSL1QmT5jY4Vf/jtaDc38OodEfdiIAHXna968Z+PgM3/q8oNQHnhTnSDlFYkWzw4jAJ4TulIFHvHjWYXRtNidPJ0B82/KNkOfmOAWEsBWfrnWaNIWzLmM65eFKpSWRt6urdtq/OBa9ZkjkE4YsUg7vermtrjLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780435991; c=relaxed/simple;
	bh=rjmOVwjQeQBiLaQlxZ274XV9FIA1bzvyI9YY8XSJRLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bjrldMzVZU4OerHEcfT2xenf8pkI+/YoERXTZlXB/FYAr4GjXUSvvmBX26gGfW2EpJSGzRQCObeJ8bj+LJswAwhQz40qmpwzHRUOdjdulc4q8j2WjnuGgJMDTDZrV5TcF+5wfJN/+4eZRTJent2mT5hkOs0pQI3EHF/nPmVBc2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V9SFy076; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V9SFy076"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18EA21F00893;
	Tue,  2 Jun 2026 21:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780435990;
	bh=jdudOJL+raYR/P30MGb9StMfBGEfajIKmHJbLO4Ebr8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=V9SFy076bGKjitzQm68Krm+0Rj2oH6tD8ejVPMJ5I/uiNj2eELLvem5TBfWJhWS4Y
	 TNxkpj0r0EocaKdfV56ca0uDZSuziD13GMeufrm1EkQYXl0dCfsFY9YyiesUFWhGHl
	 UOin2nIqMxPo5V8Rma6DTTuqNFut73Fbsj1WZ4Fu1ANDORSyKssdikJ5woI/BNsu9l
	 v2mM4MTf9qRrePcAHv2EQ+vCuYaejc3jfUE4bEVGTXMm0pKZaSeNx64p/NZBkyjPI+
	 qEcYTk0FOzw47y+XX7bp2LjYzzjiZ7m6ac/+kx2hpwt6249m/LIFyHVdITnIiP7Fe8
	 7BqzG0nolC9Cg==
Date: Tue, 2 Jun 2026 14:33:08 -0700
From: Oliver Upton <oupton@kernel.org>
To: Andreas Grapentin <gra@linux.ibm.com>
Cc: Steffen Eiden <seiden@linux.ibm.com>, kvm@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	David Hildenbrand <david@kernel.org>,
	Friedrich Welter <fritz@linux.ibm.com>,
	Gautam Gala <ggala@linux.ibm.com>,
	Hariharan Mari <hari55@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Hendrik Brueckner <brueckner@linux.ibm.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Joey Gouly <joey.gouly@arm.com>, Marc Zyngier <maz@kernel.org>,
	Nico Boehr <nrb@linux.ibm.com>,
	Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
	Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v1 15/26] s390: Add functions to query arm guest time
Message-ID: <ah9MFEq09ISAu9cb@kernel.org>
References: <20260529155601.2927240-1-seiden@linux.ibm.com>
 <20260529155601.2927240-16-seiden@linux.ibm.com>
 <ah4G847iT_pPRuQm@kernel.org>
 <ah7Ul7YwJOFuSMaD@li-d8547bcc-2d90-11b2-a85c-a70f2a37009a.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah7Ul7YwJOFuSMaD@li-d8547bcc-2d90-11b2-a85c-a70f2a37009a.ibm.com>

Hi Andreas,

On Tue, Jun 02, 2026 at 03:25:13PM +0200, Andreas Grapentin wrote:
> On Jun 01 26, Oliver Upton wrote:
> > > Add functions to convert between ARM guest time (LSB0) and s390 host
> > > time (MSB0) using new ptff function codes.
> > > 
> > > Co-developed-by: Nico Boehr <nrb@linux.ibm.com>
> > > Signed-off-by: Nico Boehr <nrb@linux.ibm.com>
> > > Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> > > ---
> > >  arch/s390/include/asm/timex.h | 49 +++++++++++++++++++++++++++++++++++
> > >  arch/s390/kernel/time.c       |  1 +
> > >  arch/s390/kvm/arm64/arm.c     |  9 ++++++-
> > >  3 files changed, 58 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/s390/include/asm/timex.h b/arch/s390/include/asm/timex.h
> > > index 49447b40f038..9ec22a28bbda 100644
> > > --- a/arch/s390/include/asm/timex.h
> > > +++ b/arch/s390/include/asm/timex.h
> > > @@ -99,6 +99,8 @@ extern unsigned char ptff_function_mask[16];
> > >  #define PTFF_QSI	0x02	/* query steering information */
> > >  #define PTFF_QPT	0x03	/* query physical clock */
> > >  #define PTFF_QUI	0x04	/* query UTC information */
> > > +#define PTFF_QAGTO	0x10	/* query arm guest time offset */
> > > +#define PTFF_QAGPT	0x11	/* query arm guest physical time offset */
> > 
> > Are these analogous to CNTVOFF_EL2 and CNTPOFF_EL2?
> 
> They are somewhat related -- we don't have the EL2 counter offset
> registers, but we still need to virtualize the guest counters, so
> instead we have to maintain the guest counter offset separately.
> 
> However, to determine the correct guest counter offset, we are using
> these new PTFF function codes to translate between the s390 and arm64
> architected counter domains.

Thanks for clarifying, I was trying to figure out how these functions
apply to the virtual and "physical" views of the counter inside the VM.

--
Best,
Oliver
