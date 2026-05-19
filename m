Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B098040963D
	for <linux-s390@vger.kernel.org>; Tue, 19 May 2026 13:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779197355; cv=none; b=b8jTr0/YPZrOmMQsuEaKMs58a+Tc/KgxllOxZCLFuoTcMFa4/0Br1LzKpI8Kndgf63cmBy6u8Xg9RjuPP7wawrieSGhJlYXAOrPwjj2dA17ZpJ/KkfYQsH1MlRrlfqScjDlKKQ3RXTOZ0UpVUdN1ZWI+RVynF+7AdKsq2qjfZuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779197355; c=relaxed/simple;
	bh=dbxAh3jWVdvQ1+R108C1f7Lp/JMDaW8ElH0OVbL5tww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qx4WVPnjpEg7jcsUPdtQMFD8k2Gu/jRTRcAb1QKZfZMX/aDoz4hUTAPb1Wpyxh7WZpTBrdZp/6LE7iriHEcvIGFQ3CXJnKNJKVq0Z5MIA+o/cRHDI6YrxFt5OddqpqCulUGIXwOPMhxqvGtEgmdfRrhPlHvyEO1d34TU2VFRALo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=HFxbGml9; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="HFxbGml9"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-90d1f03238bso437317985a.1
        for <linux-s390@vger.kernel.org>; Tue, 19 May 2026 06:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779197353; x=1779802153; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LrtAP8Eaa/f2vd8w85VzyR8xqf5rOlnG9+YArbfK2NQ=;
        b=HFxbGml95zWzPNh3GQS9uK7BC71cJiDW5UIDvgQ7rXGNX1NEWAAXq/yuMWvtvdEFM0
         4dyzWzbF5aJfYZk8Qqu9uWwa0ixCU3XWtzG0Y7zIhEMla7VA/EbxAWBf/ZT+UBGnqzk7
         PG4LqLO1B3xM8RUD5tXysopuHK+fwlbf2NnItuxqisCnuAg0QORTnlMVG8q20a1tUqiT
         jOtANU3FRTadR4lg4DUanNdWvAq67zdR8ZRqUk/9i0YEYLhJImHEsQbiHjcQUVts4aC2
         vPoXFBlPK+pDzz5sbXHAqHwZPtqElzXBq96w3+3rxV7n8hRXoB5twmFEjSA+PSh/0YpD
         PVgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779197353; x=1779802153;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LrtAP8Eaa/f2vd8w85VzyR8xqf5rOlnG9+YArbfK2NQ=;
        b=bABwgoU73dSTmtTxY49wUxdyDjDe8t8sRHGMJbZ66Mmirvas0Yv7Eh/ynXnEvXbhZj
         gN2nSZmcLjmp+1AumxyidOnbter5Ptm0U10vST4bu1CrKYyMc3uenvK9UQ/RTtV67uz9
         n/ji+6TYeZFUgSDVk8wJEK99aYcC8KAVya0BlreZi19jsgR5IKoBUiyBnpXb9hBot8b0
         CfazOfz7lurWUQGFvg/qTtGURkJkUP0aJ4Vl3Vv/zv8D6gj+xf4kbeZ49CIfB34Rn5Po
         nYWXbeqaoRxvUsamF93Dq2chQN0419T3z6p9pi8lDJB3EmYbjwZVvLS+Lv/3zagXu9MS
         +4hw==
X-Forwarded-Encrypted: i=1; AFNElJ9ZDDh3dv5q/hfF5B/L+pTLjgVxFog307OZPasONCQXErg7Y0rtGkRuP1jgAG6pCUdWWpw7oaU15Chj@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0FZ1fJNKlC9lPJps9WbgS9vcS0dVER7G11I0ryb3ds8ykI0SR
	kQtz40sFoJ/EA8JJJeo8kORhAOGZlC2Wa+bOg9sVyYHKTJvcL8fwmpAsTbjYLSjWDVg=
X-Gm-Gg: Acq92OHyKBSd3mYTbuwcPS3CGObU/thQsBBHTt0N1Xj9ELt1X+GyFoCYlfmcnJSoO8X
	Ht31HY2oGVXqZVAnfnvzT7WChSKBBR+xlANbanaU2jP9C4eIjqzKis69xkKy2mRztgNcpUtHKif
	nDs3oHsqt51ZyfLdC4DrP+nQ+GE5UWtdaKMy0CSY0n09vVj5vqPUkfsPHlOrV/RJJ9BI/i4asNT
	Zv8FsrNZ3MyMRARiALIYJ/vmBld1/2dgI6o598N1PQrw/WNnBBL0IZJPQhosQ1S6b2yd3/EDygN
	7MjsoDYJPN8cazwRnlFOsWIS3OL+EWHwZ4sU83qtOIylX66actbyPV6M4iX3PMo04eVN2IpS11B
	vzvgfwJlQudrwfqHTHZYcYEw8/D3lDfuhRMEfUJCIVJGOOFVznsrEZ0yMMv4IhhmHmXGlYGm2Zb
	1mR3dBe0oGkZ+OPyf1nL5lQ896WQldJG3BxnRnFUJ7bewneYWJLH0/+tiR47AorGs5Tvv3J7l3v
	bs97WzbHHZYq77/
X-Received: by 2002:ad4:5ca9:0:b0:8c2:7cc5:b5d5 with SMTP id 6a1803df08f44-8c8fda1ccb0mr344078466d6.17.1779197352561;
        Tue, 19 May 2026 06:29:12 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca360979c2sm90678436d6.18.2026.05.19.06.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 06:29:12 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wPKVT-0000000EubB-2Vp2;
	Tue, 19 May 2026 10:29:11 -0300
Date: Tue, 19 May 2026 10:29:11 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Petr Tesarik <ptesarik@suse.com>,
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
Message-ID: <20260519132911.GA7702@ziepe.ca>
References: <20260512090408.794195-1-aneesh.kumar@kernel.org>
 <20260512090408.794195-5-aneesh.kumar@kernel.org>
 <agSKQrSIhizCXKwx@google.com>
 <yq5ah5oaa63h.fsf@kernel.org>
 <agW5rhE9n2gDQ0w5@google.com>
 <yq5apl2y5f96.fsf@kernel.org>
 <agXaby-7L7yS3Vva@google.com>
 <yq5ah5oa59wy.fsf@kernel.org>
 <agxDxdxynp4KEovA@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <agxDxdxynp4KEovA@google.com>

On Tue, May 19, 2026 at 11:04:37AM +0000, Mostafa Saleh wrote:
> On Thu, May 14, 2026 at 08:13:25PM +0530, Aneesh Kumar K.V wrote:
> > >> 
> > >> What I meant was that we need a generic way to identify a pKVM guest, so
> > >> that we can use it in the conditional above.
> > >
> > > I have this patch, with that I can boot with your series unmodified,
> > > but I will need to do more testing.
> > >
> > 
> > Thanks, I can add this to the series once you complete the required testing.
> > 
> 
> I am still running more tests, but looking more into it. Setting
> force_dma_unencrypted() to true for pKVM guests is wrong, as the
> guest shouldn’t try to decrypt arbitrary memory as it can include
> sensitive information (for example in case of virtio sub-page
> allocation) and should strictly rely on the restricted-dma-pool
> for that.

??

Where does force_dma_unencrypted() cause arbitary memory passed into
the DMA API to be decrypted? That should never happen???

Jason
