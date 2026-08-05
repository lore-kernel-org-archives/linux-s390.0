Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633B238E100;
	Wed,  5 Aug 2026 08:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785918898; cv=none; b=btgSZfeXDgIsiFZDmi8hIHNsLbLzze60IsGhfMfPO9oJR4H0FDi7ZeBepRbjTQpK3sN1GpNijvN76ABdUhBi63/OCy/vFZUuH2h7KfF6nOjmlHLN+LBXdN6CiHaA6LM/eHc10uprzfWYo45zrO2LInpA0hj/NUiFiRlpvz8TiFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785918898; c=relaxed/simple;
	bh=UaRsb8N+FmKkIzFPZNJZ7dje7nrLAfs+VL19giDr5as=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TAFDTZ81tF3qZNuFqpyDI6LS9XGmfVy51nZ/ySoje08KSLLrbaYNnHdxqfnh2ysRSR4LMt6jeHTRb6m3zAY6ni4zEF9r4fOiM3SW17xvw7H+cn6m+TaT38HkV5MS/tFj8TQVvP7PsenvdUl6ncJw5KtE2W53a00WfYF/vxDgoFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=L7TKQLBB; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="L7TKQLBB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1785918894;
	bh=UaRsb8N+FmKkIzFPZNJZ7dje7nrLAfs+VL19giDr5as=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L7TKQLBB6BDZcm/tjJnmwzEoc5YC0FRW3VY00t4Q16FzogLxYZ+jHrK54sykLORO/
	 68/awIHaf0drXn0LmsUw6CA9QBESng2mdWejWx1OaMJtMmtFlvUaFX/zjYefo+ttoh
	 ItXOquinOrudxaEtNfl68mKH8sTNWiRdOAquGEtudkc9P6W6a/AY8jahW1y9iQSN9/
	 Xj5+nxbkBBo7+eckCMlN+KRLyV/bm+krwtTPG26BAlYhv4xpZPYR5+ELCSoVW97Wi/
	 Hd3vOJKh93z31JXt+vS8fQlLySj5zdE97dMLLZuLsLEAmMRI64MCvxaLzzWBiaxnUw
	 2NJsvgijF7YKA==
Received: from fedora-21.home (unknown [100.64.0.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 90A6C17E015B;
	Wed, 05 Aug 2026 10:34:53 +0200 (CEST)
Date: Wed, 5 Aug 2026 10:34:48 +0200
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
Message-ID: <20260805103448.44af3ff0@fedora-21.home>
In-Reply-To: <CABgObfY67mdG9QZ5__Q9GDrEq9Wutc42_tHo8YGSMOPnruZmsg@mail.gmail.com>
References: <20260804120529.1730187-1-pbonzini@redhat.com>
	<20260804120529.1730187-3-pbonzini@redhat.com>
	<20260804161549.4cd9a66f@fedora-21.home>
	<20260804161850.58c55c6e@fedora-21.home>
	<CABgObfbAveuhkjXzmemvGtycmcmDePKABr8Q35Y9mZP0den5aA@mail.gmail.com>
	<20260804164206.655874ce@fedora-21.home>
	<CABgObfY67mdG9QZ5__Q9GDrEq9Wutc42_tHo8YGSMOPnruZmsg@mail.gmail.com>
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

On Wed, 5 Aug 2026 08:08:17 +0200
Paolo Bonzini <pbonzini@redhat.com> wrote:

> On Tue, Aug 4, 2026 at 4:42=E2=80=AFPM Boris Brezillon
> <boris.brezillon@collabora.com> wrote:
> > Okay, I thought I'd ask to be sure, because of all the implementations
> > of pfn_mkwrite listed here [1], only drm_gem_shmem_helper.c and
> > kernel/events/core.c do that. =20
>=20
> Also the vmwgfx one in patch 3; and for the !DAX case ext4 and XFS too
> (e.g. xfs_filemap_pfn_mkwrite gets to iomap_page_mkwrite, not to
> filemap_fault).

Right, iomap_page_mkwrite() doesn't seem to update the PTE entry, it
just records the access. But there's quite a bit of locking taking place
before this recording is done, which we don't do in gem_shmem's
pkf_mkwrite implementation. This brings me back to some question I asked
in another thread where we were discussing another regression
introduced by pfn_mkwrite addition to gem_shmem [1]: do we need to have
the folio locked when recording the mkwrite? If we do, we probably need
to surround the drm_gem_shmem_record_mkwrite() call in
drm_gem_shmem_pfn_mkwrite() with a folio_lock/unlock() sequence.

For the record, the folio_mark_dirty() doc says:

 * The folio may not be truncated while this function is running.
 * Holding the folio lock is sufficient to prevent truncation, but some
 * callers cannot acquire a sleeping lock.  These callers instead hold
 * the page table lock for a page table which contains at least one page
 * in this folio.  Truncation will block on the page table lock as it
 * unmaps pages before removing the folio from its mapping.

I'm really sorry to hijack this thread like that, but now that I have
people with a bit more MM knowledge looking at this stuff, I'm taking
the opportunity to ask all the questions that were left unanswered back
then :-/.

>=20
> > The rest have their "generic" fault
> > handler (by generic I mean a fault handler helper that covers all the
> > order/WRITE_FLAG combinations) called from pfn_mkwrite(), and return a
> > non-zero vm_fault_t. =20
>=20
> I see; I think you can do that, it is handled at
> https://elixir.bootlin.com/linux/v7.2-rc5/source/mm/memory.c#L2681 and
> indeed it returns VM_FAULT_NOPAGE. But it's more or work for no real
> reason. Your .pfn_mkwrite is a single line of code and it is clearer
> IMO if you can see that try_insert_pfn() is calling the same helper as
> .pfn_mkwrite().

Sure. As long as what we're doing is safe, I'm fine keeping
drm_gem_shmem_pfn_mkwrite() as is and letting the core update the PTE
props. It's just that, after reading all these implementations, I was
skeptical (see the question around folio locking before mark_dirty(),
for instance).

Anyway, thanks for chiming in.

[1]https://lore.kernel.org/dri-devel/20260313111851.4c1f89f3@fedora/
