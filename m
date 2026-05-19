Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0500480DC5
	for <linux-s390@vger.kernel.org>; Tue, 19 May 2026 11:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779188685; cv=none; b=GYCQ0uzOt/lYmEvpTlcFSANCH/39yq1xu5KzChxdzr0dwJTmKShfDxn9iuMpSBfNAFiaXshQocCyaPHj9URLFhicJzJWhMfz0SFF9+CBnjk6xsXCSYMJwzvrQ/Rrdjb+BQJjGhaaPFopTpWwCh/oJJPoMHr2Y27SPw2qcBvF8sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779188685; c=relaxed/simple;
	bh=2SFj+tqay546Nu3bNSVBDfQbhniYkrhXCx7X+rN+iPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aQA43R7KmQ4PEb0sIhSVkYFhVHRa7ZezEro6H77dV5agDzkFkEML3+TL5bySgAsLfFIH3+c3arK5Th9O1Ha3lcx5lqn1LWdKPQvdA/twAmfkB47smukg5FVRw7P1KpgdGDe93znJ0nK04Lkk7G2Njjp7c74YYp5oeKrNE9lSWrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qNtwRLCC; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qNtwRLCC"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4891b4934ffso3005e9.0
        for <linux-s390@vger.kernel.org>; Tue, 19 May 2026 04:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779188682; x=1779793482; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=a+e/82ARLCMhJAFToMBvP+HlY35DA3/x25Ks+dxKl00=;
        b=qNtwRLCCRwiDLU542DKeYB18hj0yS1MxA2wIQGaVjATvMbTqgufhnfgBzaCeYuogmI
         MHBqkrd3tbd70/elHyS02lYOEwbfASHd0FiQ+K2QRufSUY2fkrdj5jbPdRQ1rX3q9ru9
         I8wY2OUojtdfAwqjoF96OUICNjMPVSB6gOVVcVz0CFkOAJ7icAftkIkCe4z9kCRh9T3/
         4QotoP+08A2u6k+4gLL9piX7enyHC75SZ+VB+RncsXtzUt67KerMvdcdIKK6S2PQnDXt
         iIq8ZQaZr31crl2ghi3d76Z5/1r8VOciYQtRUAPlTctCbj/B6hS3esuE1bwCGqjj1qdo
         d+SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779188682; x=1779793482;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a+e/82ARLCMhJAFToMBvP+HlY35DA3/x25Ks+dxKl00=;
        b=tTb5h6LRg2tLFidfimFoO6pShWI4HYl7mu+uFxjGwIFLGJNBKOfrDT5rXHx0kp84ja
         jZGS6A1cN7nKJ8a89N1rIDYZGrdh9BAnPeeG+Stf2zcFI2ER3W4DugvdVfg7bKtcuowK
         ldwzzqd6NiG+cGz92jZfLimYDzmhOabvavF4X9u3AUwILTMmyOmhpWR0P8o7USz3VAzl
         cpj+gSTq+DjY83ujrDhFkvys7Ai1zHMmGOJpVu56VYdDlGshZpPzOIfQMqtvOTTpYFVv
         7zOe/0jazZ06H9uKCcpEYnvysVmGX/yIfqjKBcP93j5Qs7+uHg8lnSfcSejRdbHrdd8y
         JsVQ==
X-Forwarded-Encrypted: i=1; AFNElJ/6CJv7y9GqprNRyl4Vts3eQpFkm8CgfZztvZCbNel984we35sRcffnd66kGodWiKlV0TyTV4KxztbY@vger.kernel.org
X-Gm-Message-State: AOJu0YyhkXt3F5MUSt3YfqjpveBPcTuCe2MENwEwZyPt10YuybR0V/Hm
	B/2go4r99DrUXNVYi3Hmws+gnPSOaEqqXfKjusSoHC1x6RX1/mFZG0ASsjrwVqmaIg==
X-Gm-Gg: Acq92OGRqEdYBYrQU4vbN4saTL2GrdzrWhrafib1BMVpQKklbX9VuT5MuCzzCJE0qGq
	gyvoA7mDvFTbsJDFKU9PVM2+WW3JtvB3jfotYDS1pZ2d1l2+92XkIpNCVv1BYPECI8v6472C4up
	rcJqQFK53Jy1i7Q/seBvCBE51ROye471ZHjABL1P3RD9h5cuBROjnyNfZSJk2+mWw3SGjIBNimd
	iaTU5KdJOIgf1HsK7juX6N4+COECe6e7aJTfeYbap5QwVXWwtHrEQBEWF8b6O43dfxMOvQNULy7
	/+P3emnPy99SKX2GEtcq9ME6VslykG7+nAArDKjzQQxTmJWZDJqRxSFRyF0lGsR387/ZOVSGoxK
	TfeRoLmypnIzqgk30mlAbJ+ZyUxIA5R9NdAI2s1+06D335Mk7+LuFkKozcyFXBwKF5pH+eC9Yya
	dFDEm/EHeDHwWif6ZVcySJ7K72yWqnovg5jyxKB0X0DEY0vRDYkiclJ40xuIx6V8aoulHGFAndQ
	qxOnBX+EJ/Sqw==
X-Received: by 2002:a05:600c:2183:b0:48a:5d95:d33e with SMTP id 5b1f17b1804b1-48ffa5d593cmr2833855e9.6.1779188681631;
        Tue, 19 May 2026 04:04:41 -0700 (PDT)
Received: from google.com (136.41.155.104.bc.googleusercontent.com. [104.155.41.136])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4c834besm340461595e9.3.2026.05.19.04.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 04:04:41 -0700 (PDT)
Date: Tue, 19 May 2026 11:04:37 +0000
From: Mostafa Saleh <smostafa@google.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Jason Gunthorpe <jgg@ziepe.ca>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [PATCH v4 04/13] dma: swiotlb: track pool encryption state and
 honor DMA_ATTR_CC_SHARED
Message-ID: <agxDxdxynp4KEovA@google.com>
References: <20260512090408.794195-1-aneesh.kumar@kernel.org>
 <20260512090408.794195-5-aneesh.kumar@kernel.org>
 <agSKQrSIhizCXKwx@google.com>
 <yq5ah5oaa63h.fsf@kernel.org>
 <agW5rhE9n2gDQ0w5@google.com>
 <yq5apl2y5f96.fsf@kernel.org>
 <agXaby-7L7yS3Vva@google.com>
 <yq5ah5oa59wy.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yq5ah5oa59wy.fsf@kernel.org>

On Thu, May 14, 2026 at 08:13:25PM +0530, Aneesh Kumar K.V wrote:
> >> 
> >> What I meant was that we need a generic way to identify a pKVM guest, so
> >> that we can use it in the conditional above.
> >
> > I have this patch, with that I can boot with your series unmodified,
> > but I will need to do more testing.
> >
> 
> Thanks, I can add this to the series once you complete the required testing.
> 

I am still running more tests, but looking more into it. Setting
force_dma_unencrypted() to true for pKVM guests is wrong, as the
guest shouldn’t try to decrypt arbitrary memory as it can include
sensitive information (for example in case of virtio sub-page
allocation) and should strictly rely on the restricted-dma-pool
for that.

However, with my patch and setting force_dma_unencrypted() to false
on top of this series, it fails on pKVM due to a missing shared
attribute as Alexey mentioned, as now SWIOTLB rejects non shared
attrs, so, the DMA-API has to pass it. With that, I can boot again:

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 5103a04df99f..b19aeec03f27 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -286,6 +286,8 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	}
 
 	if (is_swiotlb_for_alloc(dev)) {
+		attrs |= DMA_ATTR_CC_SHARED;
+
 		page = dma_direct_alloc_swiotlb(dev, size, attrs);
 		if (page) {
 			/*
@@ -449,6 +451,8 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
 						  &cpu_addr, gfp, attrs);
 
 	if (is_swiotlb_for_alloc(dev)) {
+		attrs |= DMA_ATTR_CC_SHARED;
+
 		page = dma_direct_alloc_swiotlb(dev, size, attrs);
 		if (!page)
 			return NULL;
diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
index 4e35264ab6f8..8ee5bbf78cfb 100644
--- a/kernel/dma/direct.h
+++ b/kernel/dma/direct.h
@@ -92,6 +92,7 @@ static inline dma_addr_t dma_direct_map_phys(struct device *dev,
 		if (attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT))
 			return DMA_MAPPING_ERROR;
 
+		attrs |= DMA_ATTR_CC_SHARED;
 		return swiotlb_map(dev, phys, size, dir, attrs);
 	}
 
-- 


I will keep testing and let you know how it goes. If there is nothing
else required to convert pKVM guests to CC, I can just post the patch
separately as it has no dependency on this series.

Re force_dma_unencrypted(), I am looking into a safe way to use it
for pKVM as I beleive it will be useful to eliminate some bouncing.
However, that’s not critical for this series and can be added later
as I am still investigating it, if I reach something I can post it
along the pKVM patch above.

Thanks,
Mostafa

> 
> 
> -aneesh
