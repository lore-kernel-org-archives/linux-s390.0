Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795598057;
	b=UE3tL1b2kZhZCRib5FmYyp7t3mTs6saeXdAey8dIaq9MXVU8F9dOA1k4xswUndBFU3tY
	 N+1OiKkdbgPryl+szuQXYyYDTciIkTBKqKzJSYqXn2r7vqaserXzWaU89iS5PVZi079sT
	 F0y9uoYCzpw7EDoN0RUQYeUGB+82zyiL5Efs23fN6K5GdNknTHlT0rB+MahCAqSbzm8kO
	 TvzR6LpgIm1Ov+NU+Hvhv08a+Ye2lBZoc9XkB1VD9aga+rnVC/WOtClxM4P8+e2H18DBq
	 a5vlHP1+tDrBdTqFhiWmEjnTZyBTubuaMSbrcMQeX93qDeQh4/E8RyNMFr5aTs4jd2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795598057;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=zqTNPD7bC5qKrIZEQgWRFxdczrnAZu0gT9xHLYWFyDM=;
	b=mENo3KgbyVNJngkvwQK+dXy0OGpwS+dyjCEY6wNAYq54eJqAS4O2PVhZ8E4wnPcDeAKa
	 aJF/X/8Xux7q/+IqfB2YRDb3TwOxs8mxm/saFTqgWz5Ga0XcDXKixgg5G1m8AkZeSMhMl
	 DFqq8Mqun6aUv8GTJZcZ4FSlWbc5PJvk7uGuj26dfUfkAQgUR7UcjMHilWtF+L+Bt7u8f
	 9Oxz0SXILDpLAjoBDEDgNtoKNQdkFrnTjLM7xnhV238lGdhqBd3fgDt5Thq8Cy+vDj6g0
	 5K/1DBOjoWTlvfZWXsxA2MMbYmQSHl+7kmcdD4749NI3OE2ExU9xa22Ae5mHnM/AtZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pereq.eu;
	spf=pass smtp.mailfrom=cryspen.com;
	dkim=pass header.d=pereq.eu header.i=@pereq.eu header.a=rsa-sha256 header.s=google header.b=TrvVFIj7;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E213606A6A0
	for <linux-s390@vger.kernel.org>; Wed, 25 Nov 2026 09:14:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E213606A6A0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pereq.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cryspen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pereq.eu header.i=@pereq.eu header.a=rsa-sha256 header.s=google header.b=TrvVFIj7
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4a7b8abe209so4219060f8f.0
        for <linux-s390@vger.kernel.org>; Wed, 25 Nov 2026 01:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pereq.eu; s=google; t=1795598055; x=1796202855; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zqTNPD7bC5qKrIZEQgWRFxdczrnAZu0gT9xHLYWFyDM=;
        b=TrvVFIj7shnXWXcXPS0vMv8GXOniq2cAEkrx7bERQZwnIEm0asUJYxQxNQUrxL/2rf
         EgvrryNoyyrO1N0Vb5ykY7toC54cmEWmMejWwh/f4f4D9I8OHqXh3bjl7iRE6YbTh9Ju
         8FLhpSzBy0wkk0ufWYvM5PnBwbK+fdsP3HSHaGWP46DpBMOME9jYCzG4w99dG40Ymy4U
         BI4Pm3qM+9tVNAaRIEOR/O2tb2blD2+EPJWmXY7fR5EToAF031uEo/2ym9XEmcNCae5R
         1Ob0tjqmQX8fYf7y69MQLkyK4eYFqhLlhZVZ3heEv6TNQKK9cmaJ7DCVm8Rp3Y4ebkU/
         LZnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795598055; x=1796202855;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zqTNPD7bC5qKrIZEQgWRFxdczrnAZu0gT9xHLYWFyDM=;
        b=nO68QHiceA+BEB1jroDKw0eF/ehep7hqqX7NwsKYy8sZyul1TrJdGE7TMC3CQZf2VN
         2gDkiHbV0xS6trysMkl+3YhMWtX2QlIZmKjKjCJcWIT57hgnm6EjBlPVloLdxueJ83bp
         JKNlWLGUzgFwaH5oVSZR3NpI3zjF7Bz+mdphNjUJP7eg8VFml2B96E4UacQp/EFA97dh
         M26/dzt1npuVPlY3ELVYThM76MGoQDI4p5SSOuvfG2nqPxcg+Ik3M8oLAKJTgCFbsrNh
         yOESf38FX60GHGZOjVyW/i+/YLbStk0oHyNSHil5oI1Mpas7D1YwjBM8ukoAzPwjiBk7
         kLTg==
X-Forwarded-Encrypted: i=1; AL+hErFA+3ZXvxxW6pdzRDi8fhW4r/3jKSa5TSCHkotGUxN2wvWehC45rUn1QxgJ/TN1qo1xF6nVFZKF/w54@vger.kernel.org
X-Gm-Message-State: APuU4Z/Y90wW35tYcc6UkAGG7QRcIcSzeCfu1DNIKUzgfvhAd/X5RNdd
	32kSTbL5ZaIHr6qoqm7VHzhfmYxPM8h46KTSiAsrvWBAW7RyeSMubAuoLph+M6fYUvI=
X-Gm-Gg: AZFdTZftzOw9XW0RavRIZP49FtjMRkJRpB58bmerS7aPjjts05zkTd1j+oWeIW5cdol
	0DRhcGMtsO6Ab1o0tc5OsV6ZxY1VE+rBasQnOsmjtg4isC2awlZrYkkDstDCjnnFJl5kZrW9D8R
	/Khg94Vmk9HQ1mWIrf1LnsFCxlGzplZA2KB1NlRkH6JKkcOYoiKoUZ93CV55iYUkq0ySvaiCJYu
	VEmIgoqZ33axGn5Ad3cIa4EwbjB/wIIpDQl07LDdpV9XrhrtHy/CvcuCKmz3uAhu+PeDALX9t0i
	FaLgfeU533WHihEPLTSRAmDsXGQJ1Uz++Z4APht3xkxD15TcfK/Y/EgPzox1vdVpcW0EvcMF5t2
	FNWMl8KsRY2F8VdGWfEvtXLcWdjQMFe/w2E0A9cpsSaePViLUskZA7dtRWZZJnZiHlBBkUTdiQD
	5LBHIWuHua1eckj5n+aFFNFMSjCLHT0dJx6ovccmtF8yxqgXwCQZEX9cm2Nb6X4hgR/WtrtiE7p
	AVq2eeHWDB/oSZDVmN51rK9CSUrkqpKE9CwNPCOUO58hujDyDDOz8XQsM69lgdYD4MiZc3rOXuV
	LQ8Cn1N6zu2+T7eTksE=
X-Received: by 2002:a5d:64c9:0:b0:4a6:bc53:2478 with SMTP id ffacd0b85a97d-4abb0d5256fmr33657721f8f.13.1795598054777;
        Wed, 25 Nov 2026 01:14:14 -0800 (PST)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab69bf62f7sm34532100f8f.13.2026.11.25.01.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 01:14:14 -0800 (PST)
Date: Wed, 25 Nov 2026 12:14:10 +0300
From: Dan Carpenter <dan@pereq.eu>
To: sashiko-reviews@lists.linux.dev
Cc: kvmarm@lists.linux.dev, kvm@vger.kernel.org,
	Oliver Upton <oupton@kernel.org>, Marc Zyngier <maz@kernel.org>,
	linux-s390@vger.kernel.org,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Karthik Bhargavan <karthik@pereq.eu>,
	=?iso-8859-1?Q?Cl=E9ment?= Blaudeau <clement@cryspen.com>
Subject: Re: [PATCH v2 2/8] KVM: arm64: Reset SP_EL1, ELR_EL1 and SPSR_EL1
 when resetting a vcpu
Message-ID: <awam4std0Zifdn9k@stanley.mountain>
References: <20261125-double_exception-v2-0-224689d8a764@pereq.eu>
 <20261125-double_exception-v2-2-224689d8a764@pereq.eu>
 <sashiko-outbox-232760@kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-232760@kernel.org>

Let me add the s390 maintainers to the CC list.

I considered doing it the way Sashiko suggests but s390 doesn't have the
__vcpu_assign_sys_reg() helpers so it broke the build.  The registers are
not the same so, either way, some of this is going to be specific to
arm64.  But Sashiko is correct that s390 probably keeps a stale SP_EL1
across a reset.  The s390 maintainers could probably take the selftest in
patch 8 and modify it for s390.  :)

The pKVM part was my fault.  I had a patch for that but I screwed up
and didn't include it.  Sorry!

I guess what I'd like to do is keep this patch as-is and let the s390
maintainers fix s390.  When I send v3, I will include the pKVM fix.

regards,
dan carpenter

#HashTagTopPostingRules!

On Wed, Nov 25, 2026 at 07:15:46AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] KVM: arm64: SP_EL1, ELR_EL1, and SPSR_EL1 unreset in
>   pkvm_reset_vcpu() and core
> --
> 
> commit d315f26d12c1dd260ed62612065ad5e34b6f9f03
> Author: Dan Carpenter <dan@pereq.eu>
> 
> KVM: arm64: Reset SP_EL1, ELR_EL1 and SPSR_EL1 when resetting a vcpu
> 
> This commit zeroes SP_EL1, ELR_EL1, and SPSR_EL1 in kvm_reset_vcpu() when
> resetting a vCPU.
> 
> > diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
> > index 26081d2734087..9c1b42890c966 100644
> > --- a/arch/arm64/kvm/reset.c
> > +++ b/arch/arm64/kvm/reset.c
> > @@ -199,6 +199,9 @@ void kvm_reset_vcpu(struct kvm_vcpu *vcpu)
> >  
> >  	/* Reset core registers */
> >  	kvm_reset_vcpu_core(vcpu);
> > +	__vcpu_assign_sys_reg(vcpu, SP_EL1, 0);
> > +	__vcpu_assign_sys_reg(vcpu, ELR_EL1, 0);
> > +	__vcpu_assign_sys_reg(vcpu, SPSR_EL1, 0);
> >  	vcpu->mmio_needed = false;
> >  
> >  	/* Reset system registers */
> 
> [Severity: Medium]
> Should SP_EL1, ELR_EL1, and SPSR_EL1 be reset in the shared helpers instead
> of only in host kvm_reset_vcpu()?
> 
> For pKVM protected VMs, flush_hyp_vcpu() does not copy host_vcpu->arch.ctxt
> into hyp_vcpu->vcpu.arch.ctxt.  Instead, on PSCI CPU_ON,
> handle___kvm_vcpu_run() calls pkvm_reset_vcpu() at EL2:
> 
> arch/arm64/kvm/hyp/nvhe/pkvm.c:pkvm_reset_vcpu() {
> 	...
> 	kvm_reset_vcpu_core(&hyp_vcpu->vcpu);
> 	kvm_reset_pvm_sys_regs(&hyp_vcpu->vcpu);
> 
> 	/* Must be done after resetting sys registers. */
> 	kvm_reset_vcpu_psci(&hyp_vcpu->vcpu, reset_state);
> 	...
> }
> 
> Because neither kvm_reset_vcpu_core() nor pvm_sys_reg_reset_vals[] resets
> SP_EL1, ELR_EL1, or SPSR_EL1, a protected vCPU that cycles through PSCI
> CPU_OFF and CPU_ON re-enters in PSR_MODE_EL1h with stale SP_EL1, ELR_EL1,
> and SPSR_EL1 values.  Resetting *vcpu_sp_el1(vcpu) = 0 in
> kvm_reset_vcpu_core() (which also covers arch/s390/kvm/arm64/reset.c) and
> ensuring ELR_EL1 and SPSR_EL1 are reset for pvm_sys_reg_reset_vals[] as
> well would keep all vCPU reset paths consistent.
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261125-double_exception-v2-0-224689d8a764@pereq.eu?part=2
