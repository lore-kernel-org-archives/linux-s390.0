Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED92853445B;
	Wed, 14 Oct 2026 13:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791985987; cv=none; b=agqJ+2UrPO29QBE6h4UtFqL7U+2RKrVjrM2QByNdfl5oMpBU/vZ3h5A5/Nl56kvYtAl6QbY74EwAsDOkVfX9hwtsiu1XO0D17sXyUi09mVlF9aowI8o+Sxirx8OrH89UtahGeRGUspO/zH+1o3NisrPDRPd04hXk1pzPgqwSvOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791985987; c=relaxed/simple;
	bh=YX3oKQFid4+2wlIQM4M+cUy+JgcjW23uXS4Jv7bE5d4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=des4qQDYdwjJk5DM3Nv/lgjqtXvi/lbdpCLRLvkBBVJJTmyLeXMecTmbD8+yaMerr5KnM/eQj9pGqP8vwUCwEdJ0jqbcS7gOj/+eDERjGDudsCVIIHtAF76CBzxU6wnLclr8qxybRdeNmDVBbKDb23vlym9Ot7Q89jOwcIA2snc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m6UV0s6N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m6UV0s6N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96ED41F00A2F;
	Wed, 14 Oct 2026 13:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791985984;
	bh=YX3oKQFid4+2wlIQM4M+cUy+JgcjW23uXS4Jv7bE5d4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=m6UV0s6NCYtNAyc6gKXbw6p9xcuxFVBgz5sETFnNcoD0b1VSadNMRLxMSDoEp2R0Z
	 ayMNY2TEmre09azqpKckR2WqLRK6xI1sh0wse7E66Lbl1T1BIVN3UHs+zoSnMvZn+G
	 smIZ7v01RFqJzpD0xouqoSw1WA6HZSMOfXW3qZHSVx+nmeONzvToNNiwdGZBMT1AJ+
	 VPtgfE1NfwAl2DfNA93srycj8qJkEmFXS02M+zWFA5otycQ3r2ZEz3EXXi9PaCLWzm
	 bVlKEGMeias/1TNIwPaTh9Cnu9Hlkolp95ua3rzDNdpFsKtBOqkz/3/XiiiV2Slwv8
	 SehyAc2HzLzSg==
Date: Wed, 14 Oct 2026 14:52:51 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Fuad Tabba <fuad.tabba@linux.dev>
Cc: Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Joey Gouly <joey.gouly@arm.com>, Steffen Eiden <seiden@linux.ibm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Mark Rutland <mark.rutland@arm.com>, Randy Dunlap <rdunlap@infradead.org>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	David Hildenbrand <david@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Jack Thomson <jackabt@amazon.com>, Jack Thomson <jackabt.amazon@gmail.com>, 
	Alexandru Elisei <alexandru.elisei@arm.com>, Vincent Donnefort <vdonnefort@google.com>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Leo Soares Passos <Leo.Bras@arm.com>, 
	Wei-Lin Chang <weilin.chang@arm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH v4 01/14] KVM: Allow architectures to disallow pre-fault
Message-ID: <as-I8TN27Kz6HS1Q@gremlin>
References: <20260923-kvm-arm-prefault-v4-0-d4b0b4dfa8c3@kernel.org>
 <20260923-kvm-arm-prefault-v4-1-d4b0b4dfa8c3@kernel.org>
 <CA+EHjTzDYSuBVEc+SMdDa41sq-ET=m_oWW0gL9dYf+AumPYPUg@mail.gmail.com>
 <as-H1zaslO-Bwf5q@gremlin>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <as-H1zaslO-Bwf5q@gremlin>

On Wed, Oct 14, 2026 at 02:48:02PM +0100, Lorenzo Stoakes (ARM) wrote:
> On Wed, Sep 23, 2026 at 07:52:27PM +0100, Fuad Tabba wrote:
> > nit: the comment above the smp_rmb() in tdx_sept_map_leaf_spte() still
> > says pre_fault_allowed is read by kvm_arch_vcpu_pre_fault_memory(),
> > but after this patch it's read here.
>
> Ack, will chase that up!

Oops disregard!

My mail client managed to confuse me :P I see that Marc already fixed this up.

--
Cheers, Lorenzo
