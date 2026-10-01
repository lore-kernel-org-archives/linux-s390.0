Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F415848425C
	for <linux-s390@vger.kernel.org>; Thu,  1 Oct 2026 12:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790856701; cv=none; b=FFvnfPhB7lG239WyAbX6NCYJhLQ9FWI+ipui6WPqgqe+mpuK7geU6D+mKqTjc9pazbLuywzbaKhMM1DADPU+jkx5kECthiloIP0SYwmM5kphO8YRFvYDMJjVwFbugSLhU5HCiDkrblE/F3dRWat7dh9Yiv5EpiRUvFdb+O0qfxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790856701; c=relaxed/simple;
	bh=yCbYjKH+S5QEfiIfZQdjrjC5qwYdJpqahL/rYFDjmls=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=vDfodjOXKw8KE0taAQqeI5DHWWJX/AzQ3pBATqm//i8CcaIx6g46Ho7x/iEzxqGaSfIXFNHRMdtuK64xsll6DDTrMRBp06O23yJGvb4ys6GWYh518iLc8IoNBIOJHzpiMsVGQg5hN6ce3OJbGcf6ato1lXJLqa7V+RktqcT04X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=DdZptR14; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MTMJkvNI; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="DdZptR14";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MTMJkvNI"
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DF06F1400100
	for <linux-s390@vger.kernel.org>; Thu,  1 Oct 2026 08:11:30 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Thu, 01 Oct 2026 08:11:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790856674;
	 x=1790943074; bh=LrP4wnPTH49w5JcU809MXbLlJcIqsc8CmLzg77Y19Yo=; b=
	DdZptR14wbpanHzm6uKkKZ0c9hXpIWiEzd/rLBR76KL5KksnHcsvaER2Qu/EZLX2
	iTysz/+vPCwRIZ35fPbIJu8HtFLcQEOTDdrccmt5LhVUFNujINRMaSkpHpo7Hdk4
	rJk1InvEJnIw813C43vLa5Qr5CwpHE/r0CO1nvF4hPMtCjKDqMuqMgQJ1svVepYk
	GvV80ITRAyKcVoU8xpiSTLx2ParbRk2TkJDOZNpqE1tWZjqqJywaEbcGw7S2xgiG
	8KZbkkO4Smu6Qyr87tB8+t5EYiigRa3FeL/96OLJ2poloiH9igIqDbcqKnpglzuB
	8PjKYewAK3Dg/3nCBXskvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790856674; x=
	1790943074; bh=LrP4wnPTH49w5JcU809MXbLlJcIqsc8CmLzg77Y19Yo=; b=M
	TMJkvNIJV1H2eTr4uWJq7gIRL4MykfuemTKy3B8qDSQbSo0zIeVIXZKoDMnJ0QeY
	cRL8+5bXAI54jMaw+DclA5lCIqX8N7DRrMcllnGqJcC5+4aofEPGPXW7wMSUVBkY
	To8PD1I8mkSFZBr75Np9MWQ8yhQ7NyMQfjuud7GZqLY6i+GBYrKuW8Sika6VR0Mv
	FM0YqHlrIGa0jUZtikBYE5yZAUqFYZK0dmj7LTgFfh6hRFDVe0w5Q33s6YBmZsM+
	TsNQrs8hHK8OwprTOFSJwkO/Wf5efJdOkjKdL2qyssfe3qqsNjt8BD/YSfAQcqbx
	6OOTYNm6IJNHvRgu9BwWA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790856674; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+;
	rt=PGxpbnV4LXMzOTBAdmdlci5rZXJuZWwub3JnPg==;
	s=fm1:rsa-sha256:S9v4R28a5lziAC9YN4FG/JqxPpIMga7celUmXeCY+V5/oSz
	DhiSjo+Pd2pPutFMWe8C4I7PpGLXUQyIiCESKDwTOvX8/jZeesKkwtJYlX8jfEyq
	oAgBvSCVBSaGhXj3yqZOIg/19jtVSmLPXjEQHdUs9VohL+kti7VEeVG9G9nMZ0z3
	OGL/bL+xaco6FvEVAqMT1lrXsms2BCssYUMJzdhRk3lIxR2ZOnUGsTTNZac/EyH/
	obFTxYc1pJxR/Ck4zZZNg0VX+IwrPP1bkWWvVPGnt8h7vHBXqVSYspWt4NUXoebH
	+aMofXmABRnIY3yMdTTUrRQXuyCOwL/iBoDc7QA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:0d3aVtmayZTOzeQ+MpEcEkolJRwy5WF92/2k3IpurhQ=:yCbYjKH+S5QEfiIfZQdjrjC5qwYdJpqahL/rYFDjmls=;
X-ME-Sender: <xms:2k2-aiTRKWbMc107WhYzHUymmXtYgzuL5oAi-X1o6feSNt-MwREVtg>
    <xme:2k2-aik4c_KL12gKMLv9VYRj5ZxXpw9mV_peTngbibceQZCIiLTLMk7fQXLhxlE0D
    l_uDmIrMBPDhtxifqu3dqdCAK4IYCNgAH2fZAvJwGy0MZLgLkxHe-hQ>
X-ME-Proxy-Cause: dmFkZTGKlnIEsaaPd8MjhsmVKAuQGGCkE6iNhqa5cgmJ0cUZLPa4JCOr3xxfefUsNnq5Qu
    zIlkZrYxyZZ90IF/NlCb7O0gNqwyI0nsaf77oXEqC6rcMe0AJlx1DbPIELICOaraMNVL92
    6YD4uYwOQjzFJSe68LWxRWl4gKdGiTNLNgpwEuhc4yqMab+1djzPF1FbsLmn6QlxedBlUz
    QE3A8cLPSz0AE36Lw+kxBpXqqnwRsojToOFL+h3cipO/SFygy55CoVQWctruTKuv4FhoUW
    vEWWPlLDvbsfaWv1HNFhJsDx1888K0soTkGt1ki4fl2kkn+ckgLKjRJkrYgYxrcGPfHTqO
    /U6VHuVF8Gl+WbJM6vfMhtApm5BKKwPu2MYVZh/dd/u7pO3yjAtlHdM1OtMZEYxTrQQVgn
    DOJE4fvSrQqtqQfKX6KzzPM+I3vemYarjMgstK/GlVj5OSnz7pMRx908MvtCOlH4j9SlbA
    +B7i6gOX2+QOJ9kzn8mVblz3NJfUfzzjFA/7H1F7crEh4epIST19sEeHee+RBIZM9qhvjs
    85fruzJ6LWf4fJ8aKLau5nkmelaefTXuDwSKfj3H3VNz43iuHRRvFLPxt9TT9eaxq8hLAw
    p4LOQzewFyYLMGCm3NDh14uUgZGNpbLZ5/ox80hAW52RxUDHGYuVp+yY7MSQ
X-ME-Proxy: <xmx:3k2-arboxQ7fgmQSr02igr-P_X0AC1jaCz4CHvCFupNkg6NACoELFw>
    <xmx:3k2-avz2MRDuBo2q7ocXxhEGE4TMtfUeCjRGvXUl7FsZySNYSepcNg>
    <xmx:3k2-aqaToNTnuqqH1NTAkNGi7kgMn8cmSG4Qomxq2MZqShqXpauA7g>
    <xmx:3k2-amyTTgKTSRZ_1u8LkWAANhuCjngI3vrEbXzXCK1vz6dQeLne7w>
    <xmx:4k2-auNCvzqprV9hX_UxKrvj8cfadVF3_geCgaO3KJdhUG4fMXa8qFc4>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 3DC4332A008A; Thu,  1 Oct 2026 08:11:06 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AyQhVaDaKSSk
Date: Thu, 01 Oct 2026 14:10:06 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Steffen Eiden" <seiden@linux.ibm.com>, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>,
 "Andreas Grapentin" <gra@linux.ibm.com>,
 "Catalin Marinas" <catalin.marinas@arm.com>,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>,
 "Claudio Imbrenda" <imbrenda@linux.ibm.com>,
 "David Hildenbrand (Red Hat)" <david@kernel.org>,
 "Friedrich Welter" <fritz@linux.ibm.com>,
 "Fuad Tabba" <tabba@google.com>, "Gautam Gala" <ggala@linux.ibm.com>,
 "Hariharan Mari" <hari55@linux.ibm.com>,
 "Heiko Carstens" <hca@linux.ibm.com>,
 "Hendrik Brueckner" <brueckner@linux.ibm.com>,
 "Ilya Leoshkevich" <iii@linux.ibm.com>,
 "Janosch Frank" <frankja@linux.ibm.com>,
 "Joey Gouly" <joey.gouly@arm.com>, "Marc Zyngier" <maz@kernel.org>,
 "Nico Boehr" <nrb@linux.ibm.com>,
 "Nina Schoetterl-Glausch" <oss@nina.schoetterlglausch.eu>,
 "Oliver Upton" <oupton@kernel.org>,
 "Paolo Bonzini" <pbonzini@redhat.com>,
 "Sean Christopherson" <seanjc@google.com>,
 "Suzuki K Poulose" <suzuki.poulose@arm.com>,
 "Sven Schnelle" <svens@linux.ibm.com>,
 "Ulrich Weigand" <Ulrich.Weigand@de.ibm.com>,
 "Vasily Gorbik" <gor@linux.ibm.com>, "Will Deacon" <will@kernel.org>,
 "Zenghui Yu" <yuzenghui@huawei.com>, "Lorenzo Stoakes" <ljs@kernel.org>
Message-Id: <e2742ccb-6b91-463c-a148-30b7e2f41e9a@app.fastmail.com>
In-Reply-To: <20260930173441.66762-24-seiden@linux.ibm.com>
References: <20260930173441.66762-1-seiden@linux.ibm.com>
 <20260930173441.66762-24-seiden@linux.ibm.com>
Subject: Re: [PATCH v9 23/24] KVM: s390: arm64: Implement basic page fault handler
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


> +		/*
> +		 * Check for a cache maintenance operation. Assume the guest is
> +		 * cautious and skip instruction
> +		 */
> +		if (kvm_is_error_hva(hva) && kvm_vcpu_dabt_is_cm(vcpu)) {
> +			kvm_incr_pc(vcpu);
> +			ret = 1;
> +			goto out_unlock;

Hi Steffen,

[Adding Lorenzo Stoakes to Cc]

I see this function fails to build on top of linux-next, as the 
kvm_vcpu_dabt_is_cm() function was removed by commit 18b94675b1fb
("KVM: arm64: Use ESR helpers in guest abort handling").

I used this patch to make it build, but I'm not sure if this is
the correct fix:

diff --git a/arch/s390/kvm/arm64/mmu.c b/arch/s390/kvm/arm64/mmu.c
index 3c1c8a2def73..7ee157c61d70 100644
--- a/arch/s390/kvm/arm64/mmu.c
+++ b/arch/s390/kvm/arm64/mmu.c
@@ -119,6 +119,7 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu)
 	hva = gfn_to_hva_memslot_prot(memslot, gfn, &writable);
 	write_fault = kvm_s390_cur_gmap_fault_is_write(vcpu);
 	if (kvm_is_error_hva(hva) || (write_fault && !writable)) {
+		unsigned long esr = kvm_vcpu_get_esr(vcpu);
 		ret = -ENOEXEC;
 		/*
 		 * The guest has put either its instructions or its page-tables
@@ -143,7 +144,7 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu)
 		 * Check for a cache maintenance operation. Assume the guest is
 		 * cautious and skip instruction
 		 */
-		if (kvm_is_error_hva(hva) && kvm_vcpu_dabt_is_cm(vcpu)) {
+		if (kvm_is_error_hva(hva) && esr_dabt_is_cm(esr)) {
 			kvm_incr_pc(vcpu);
 			ret = 1;
 			goto out_unlock;


      Arnd
