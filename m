Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D17E305692;
	Wed,  7 Oct 2026 12:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791375508; cv=none; b=Udja6wic1AUDJNR9TAWD7zxomqw4bFObPx8icnX4C/5j85pH+UCCVptvdA+8mnlVAX+1RbegvFYx78Lo0DLz+Xrxd/OE3NL4Vx4m/z9eiS1wPSN1sELbglV35poXE/6uuHd2ZqF9TXaJm05/AAhHNwpCBHWkbnG1V1TPvppNq0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791375508; c=relaxed/simple;
	bh=+vWVYeszz1wK1o8ezDWC6B5I+r/0UmJJAENpW+bVMpk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UpNu5GQas7QrhenrabrXO2+al8Fhv9xeusErQHRTrN5RMDGTZWMEnbzTiIbstcTDsOFHvv63BAQnAkfhGoEc9hMj2tb/c367vyx7HvXzW2crySqqKeSnwJXgDidGJwK5Sff+X+GXCqNQn7c523bLMwVw9FIV9GJLHDDU/CiwRjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=euozqhSF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="euozqhSF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ABFE1F0089B;
	Wed,  7 Oct 2026 12:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791375498;
	bh=2WgWLAiPotutYayQG3trpdPvMIi0zMN+OiIn2PqYtBg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=euozqhSFQzcWnwMmFjHgWU9CQ0mRmnQ/1D4I+KBxZigk9xnWjARxsK7JZVR2odRko
	 M7uAKQ+ZnGHyc5Bw3SYbVoM2TV8SA+mrf+7JM0mxUjBwSrHe30dT8j60lFGuKvhbgH
	 jr+z075r7gGsj1avvxBkbsgCasm59loy0lYr47kiXLPk1EMD2xU2/2psHUTcLA80Y6
	 tLAdrspaLYKQXCPufkliH2EcXJL45rIGwPAuPpbZne93fbmu3Ez4WwG7bx0fhw5d/X
	 sO23nTup+cY08SZFL/7Cdf5XhChJ7GZHQSpaluQjJR/rdhlksim5K2/hznwDcX7xu1
	 O6S7FIGvrY0Jw==
X-Mailer: emacs 31.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v6 6/8] dma: swiotlb: Centralize memory-encryption pool
 sizing
In-Reply-To: <asYZFXGyafRjjBS0@arm.com>
References: <20260924060756.1325156-1-aneesh.kumar@kernel.org>
 <20260924060756.1325156-7-aneesh.kumar@kernel.org>
 <asVs3doaJ4WrT3M2@willie-the-truck> <asYZFXGyafRjjBS0@arm.com>
Date: Wed, 07 Oct 2026 17:47:58 +0530
Message-ID: <yq5atsmx3ds9.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Catalin Marinas <catalin.marinas@arm.com> writes:

> On Tue, Oct 06, 2026 at 10:49:17PM +0100, Will Deacon wrote:
>> On Thu, Sep 24, 2026 at 11:37:54AM +0530, Aneesh Kumar K.V (Arm) wrote:

 [ ... 22 lines skipped ... ] 

>
> That said, such heuristics should have been a separate patch to make it
> easier to review/drop.
>

I kept them in a single patch to avoid breaking bisection. Otherwise, an
intermediate commit would allocate a swiotlb bounce buffer for pKVM.

-aneesh
