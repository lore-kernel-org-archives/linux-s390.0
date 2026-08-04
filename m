Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA98D393DC7;
	Tue,  4 Aug 2026 14:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785854534; cv=none; b=IFRqsvJXXtDzjEbb/Qk7Mxsi5zSNfhtWWttgR9IW2+TedpPdo3t8N/t1sitpAXHq2HHdq+MMIyeGW/UV2BT9O5B3K8V/3pBKAgYcnHAGWuJZ17ueC4xuG1K2656bMco2fkh0b99h47eFQ6JzQY+1vKLR+fsHZXcaIrErXKtEUE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785854534; c=relaxed/simple;
	bh=OqhWvtZXhc+G73nSM63Uipt1epzkVmRKYCPHPRJIK0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hnttbr7OYa3gXFnoVRNAuP84U8aCMdB6UnZcM8dlqROZSO6EnE/nSL0hhHcvK8uymQP6R3ttDGxnHbhnFfOM3AAA3/HIFH3RdTD+5D5mWdWFiNuLJNMUGai7TbdxNE2s4qjSma+MU9CEcXgqMqXYOZeQR5N1EsSy6kM+7MWNBew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=HtH0Ve/V; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="HtH0Ve/V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1785854530;
	bh=OqhWvtZXhc+G73nSM63Uipt1epzkVmRKYCPHPRJIK0Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HtH0Ve/VLbxeWT20pqClozODac1Dw4+T1z2o+/A49QRdMP7pNhRDg73VMW74+qIo/
	 1Myw+x4+SK7EUzokQ2g1afHUPDhju9Zc78F7603PJMDdlCHVA50LZCX+CJXMM0F50p
	 UImFSnEFG1TZJLsSL1qLB3UObDnRl70W3kgJHo7UWmMd0HPita46KqAZm8wo2EZGwO
	 h8/mYsGf/09/AoX4XceNBuio8K5egqnTVoWrj+vXJTBJLcu8FzHRYu8ek8MNSThce6
	 toIGSNV9gvyYoypdleU7GYq4PpCRSsxB6jPAfzCFP4Eqg4S6TGjZci2m/K3t/KuWgn
	 d6R35ElJDipgw==
Received: from fedora-21.home (unknown [100.64.0.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1468917E052F;
	Tue, 04 Aug 2026 16:42:10 +0200 (CEST)
Date: Tue, 4 Aug 2026 16:42:06 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Alex Williamson
 <alex@shazbot.org>, bcm-kernel-feedback-list@broadcom.com, Christian Koenig
 <christian.koenig@amd.com>, David Hildenbrand <david@kernel.org>,
 dri-devel@lists.freedesktop.org, Fei Li <fei1.li@intel.com>, Huang Rui
 <ray.huang@amd.com>, linux-mm@kvack.org, linux-s390@vger.kernel.org, Michal
 Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>, Sergio Lopez
 <slp@redhat.com>, Sean Christopherson <seanjc@google.com>, Thomas
 Zimmermann <tzimmermann@suse.de>, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/6] drm/shmem_helper: use vmf_insert_pfn_mkwrite()
Message-ID: <20260804164206.655874ce@fedora-21.home>
In-Reply-To: <CABgObfbAveuhkjXzmemvGtycmcmDePKABr8Q35Y9mZP0den5aA@mail.gmail.com>
References: <20260804120529.1730187-1-pbonzini@redhat.com>
	<20260804120529.1730187-3-pbonzini@redhat.com>
	<20260804161549.4cd9a66f@fedora-21.home>
	<20260804161850.58c55c6e@fedora-21.home>
	<CABgObfbAveuhkjXzmemvGtycmcmDePKABr8Q35Y9mZP0den5aA@mail.gmail.com>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 4 Aug 2026 16:34:10 +0200
Paolo Bonzini <pbonzini@redhat.com> wrote:

> On Tue, Aug 4, 2026 at 4:19=E2=80=AFPM Boris Brezillon
> <boris.brezillon@collabora.com> wrote:
> > On Tue, 4 Aug 2026 16:15:49 +0200
> > Boris Brezillon <boris.brezillon@collabora.com> wrote: =20
> > > Actually, if we're making the drm_gem_shmem_record_mkwrite() call
> > > unconditional (for PTE and PMD updates) in that path, can't we drop t=
he
> > > drm_gem_shmem_pfn_mkwrite() call living in drm_gem_shmem_pfn_mkwrite(=
)?
> > >
> > > Also, I'm not even sure we can end up with write=3Dtrue for PTE updat=
es,
> > > because our pfn_mkwrite implementation returns zero, not VM_FAULT_ERR=
OR
> > > or VM_FAULT_NOPAGE. This means the default RO -> RW PTE upgrade
> > > implemented in finish_mkwrite_fault() [1] will take place. If we real=
ly
> > > want out try_insert_pfn() to be called for those RO -> RW updgrades, =
we
> > > need to call try_insert_pfn() from drm_gem_shmem_pfn_mkwrite(). =20
> >
> > Nevermind, it's all explained in the comment you've added. Sorry for
> > the noise. I keep wondering if we shouldn't call try_insert_pfn() from
> > pfn_mkwrite() though, like is done in other places. =20
>=20
> No, the .pfn_mkwrite() callback is invoked when a PTE already exists,
> and mm/ already takes care of making it writable. So there's nothing
> to insert, you just have to take note which you do with
> drm_gem_shmem_record_mkwrite().

Okay, I thought I'd ask to be sure, because of all the implementations
of pfn_mkwrite listed here [1], only drm_gem_shmem_helper.c and
kernel/events/core.c do that. The rest have their "generic" fault
handler (by generic I mean a fault handler helper that covers all the
order/WRITE_FLAG combinations) called from pfn_mkwrite(), and return a
non-zero vm_fault_t.

[1]https://elixir.bootlin.com/linux/v7.2-rc5/A/ident/pfn_mkwrite
