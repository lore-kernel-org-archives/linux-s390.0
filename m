Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEED3DAAC3
	for <linux-s390@vger.kernel.org>; Wed,  5 Aug 2026 06:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785910117; cv=pass; b=HilWgNDxURMaKOxDnLu9Y7T2k7itrK053mbyuzSOa5SzwSDE8xnSK4/uxTMz5hNBjoHoH/18WL19M3BJFGqxWhcOodmYIb5jvZqdK9YUXaZB6ixK6jDJpRuuPWKAgJhwXAlONYcl+vFWzZNuxldL1yJ2U02v2YZy9/PH2Yr24EM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785910117; c=relaxed/simple;
	bh=W0Sm6aitHsc62gyEgQg2/9qpXlfx9wA/VX2KIRUAVSU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N7C191IHcR9k/TNzhKOWcp486Xk4pvHBD7IVim1Q8ozup+sm/PORGXEWvy5Zb9SOK/mXlcQd3RZo+phYMCSCItdED7WDWqROFZbdEUq8+rXqlaMmPa3Uv8nhCmGFFaCctkSYeLhd0TqXVuAxbnwRkjHfDgs4yWCBkDa9qUZwWA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hZFLiu3U; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=i+y5LgfF; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hZFLiu3U";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="i+y5LgfF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785910112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W0Sm6aitHsc62gyEgQg2/9qpXlfx9wA/VX2KIRUAVSU=;
	b=hZFLiu3UwUoW2CwdY6gEUvQDxXKoHngko7VL2leRakgVyhEHNySZZVGhEE3N85C9iKFZtE
	SR9Xm6562dgTI6qF/wnLs+3EMkGa5lzbkFlQwNZPNsBXioSXpQIdxeRfedTBj5Lx0E0Qqr
	h+mFlBMv4c+GA3DKqa1wBOQ5iaFmzb8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-svpBQ6JQMIudT8zC59Hd_Q-1; Wed, 05 Aug 2026 02:08:31 -0400
X-MC-Unique: svpBQ6JQMIudT8zC59Hd_Q-1
X-Mimecast-MFC-AGG-ID: svpBQ6JQMIudT8zC59Hd_Q_1785910110
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-47f810c8aebso296889f8f.2
        for <linux-s390@vger.kernel.org>; Tue, 04 Aug 2026 23:08:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785910110; cv=none;
        d=google.com; s=arc-20260327;
        b=bqBxC9WL7m+ROBoDChiy7m51HRbI+7VVRfyKAUzCnCEAjRv6lbygpAcFaSAV3+VhcY
         cpbzd85PNFMNeBeOG7+T1M0ukPh3u3I8gp2GRXkVXBsTFpQeavcUdxuW89VwUgQTqehw
         tWv1WirNVkwPR+3qN2+eeSVUNzhnew14HD2VHXxT0OYnm5oYjna6dBZ5I1uVXGAySZC+
         mhz0n4vtzcHsOzcYrSSOlVSsuwPi7BuZ947jZMeJ8vndXpIFvxzD8AjfUmAt7MrjLAQU
         fWrUNa2NJwxlI2d7Kd0t63vIG+35r6wXvmTQ22qBmRXLWUo0Xm73biX5OsgEXVMLHDdC
         erOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=W0Sm6aitHsc62gyEgQg2/9qpXlfx9wA/VX2KIRUAVSU=;
        fh=d68WwMuQckUBzEtMFB9y5Ml5snDnwVBqzxFvSemSrWE=;
        b=ikQTGOftlYzElvK8XUZEuFSJZb2wPsYnIPj1CcjAvErVzy6x0nQ615qGf9nbzqvkui
         DnbwyMguiEKpJBJkqDZK/5bex0bOBp/iJP3d/WELILKHSH01Ox6hCAtWISvUorHS8dMH
         Ebb1iIspEf2mmnxXMgBzT/OufTgg5yOPPUrbeRrpvwk0j8u3O2VbhcUFoDhTnjnPS2ZV
         PW0yCzrl2AJ7FUT8sRBwvIQlPzx3tn/X0BJbUfvinfW6Rgztu5BBKUonZrq+jXZribd3
         0yNRtsZLG3q9iqAaUwmSOTn9bF43+8XN9sQiXTT9LnRkRO0ufBv3aLwxe7ikEXWUXrrR
         yV3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785910110; x=1786514910; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=W0Sm6aitHsc62gyEgQg2/9qpXlfx9wA/VX2KIRUAVSU=;
        b=i+y5LgfFY/jp9p2qY1DrA/Aq5Jgf2ReSbS7NdouwIkk8bNPUozzCpHECiXVSuaVsIU
         A9zKCMSZnzsvYsYCIing134gae5QMiD/89iX1i91Lyn3wT7WUBE4SOx/UkpGRLHzFlg0
         aSHMiH95oOmJonCtFxg+j0u8aiAGUHrZlXfyNpHfbJh2BBnUPy8UCmjVZ2ZsP+1mmvF+
         xDotYXJiCaF8bFgjP2pmM8wER8RFrR+abo76NpO39d7lwMT5RqtJ4f4Ppu83VNII9krf
         xQdunnII9lWsEydnDOS30fuvQk4txoU5zwr+nbwIoJxFmInpBatGIiOw9e7QVSnAVBE6
         YOaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785910110; x=1786514910;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W0Sm6aitHsc62gyEgQg2/9qpXlfx9wA/VX2KIRUAVSU=;
        b=phxtgFPR/EdLx2IGzYIb1DdF5O17YrLRimFSoqlZ6LmLwc2MFM2/QCPGD95PNMU7G3
         WOO4VwVBYARTBm8fcTdlIJNGxWLbbQiO9x19dQ9Fi17ZQRhaPgmbjWc9VranPVnTnFPZ
         FYe/+FpVZnv2Zf5DjOTzAXAkBWtwrZSIg63W3SkB6WJjKpgIxDcams8xE9fs10lSkan9
         oAbFa1iSGIEaOtJAgXIbruR5O7O26nfiTN1RZ7uIzQW4g8ux8/mHdWicNMgN/IG55ubP
         bzGl+BP1StEP40drJhZ7+1TzRnq9zeTdG3P4XtECzaXX0Sn5maDIYj1fGffS2so+vxGL
         ei1A==
X-Forwarded-Encrypted: i=1; AHgh+Rrl6xv6z8ihl6cIaMZGQ0hLP826gCnX5W5R647WbCjTSNOQKiBODJpVmKIhKhk1nryaZzGdjqY/1Led@vger.kernel.org
X-Gm-Message-State: AOJu0YxT9CAI0ZQ3nXNe8dnUxeEgsuJ4nj2E1zcWDDVk2w+oTPYwXtOM
	2y/2upMQAesc65jxFOafZL3BfLl+ZYygMOJVjV902wgS9Ub3Pky3eZecnd4j8nK8mWhmpRj9F3y
	cGwnywMbLfVKMZbGxyVSZdzf6MHQK4WO4YEC17iV1zy4vcNpFYwLRjBjUY3xYtccx/DI9uPpT9n
	DBYu5pD9nTNpJxghlv70rGcDK/MfL53GsnlRLMkg==
X-Gm-Gg: AR+sD13olT3+HHT9v91IyX1LuCx0QQkGCTA/glPICkl6lgrbG5cIXqJ7IWi4P+cgSLo
	B6O5XdLil/ROCrAYBnr/YM9zivkYQPaFbfXGEHr10t1N2fLA32XKwVE6FUo2WTiiFtDtdwUYvL3
	PrbtK9KJDleFCqgCdJMp/kN9eUl6NX3N1XVugJ8FNbssDm5qZBdpla+8EIEUVBp+x4JYkSaichT
	CedWWFAorENqdbhO6uEuIGnKbulQF/qc4uG3/DLdOgXTgDXNWrqYhXeNoE=
X-Received: by 2002:adf:e012:0:20b0:47f:753c:5393 with SMTP id ffacd0b85a97d-47fec4e888cmr5402586f8f.6.1785910109878;
        Tue, 04 Aug 2026 23:08:29 -0700 (PDT)
X-Received: by 2002:adf:e012:0:20b0:47f:753c:5393 with SMTP id
 ffacd0b85a97d-47fec4e888cmr5402532f8f.6.1785910109519; Tue, 04 Aug 2026
 23:08:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804120529.1730187-1-pbonzini@redhat.com> <20260804120529.1730187-3-pbonzini@redhat.com>
 <20260804161549.4cd9a66f@fedora-21.home> <20260804161850.58c55c6e@fedora-21.home>
 <CABgObfbAveuhkjXzmemvGtycmcmDePKABr8Q35Y9mZP0den5aA@mail.gmail.com> <20260804164206.655874ce@fedora-21.home>
In-Reply-To: <20260804164206.655874ce@fedora-21.home>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 5 Aug 2026 08:08:17 +0200
X-Gm-Features: AUfX_mzo9t9ubVXz5xpYzVx4R9t4U8bdls__QKfQW65v6eCkMtC4FUkJ5hgXDI8
Message-ID: <CABgObfY67mdG9QZ5__Q9GDrEq9Wutc42_tHo8YGSMOPnruZmsg@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] drm/shmem_helper: use vmf_insert_pfn_mkwrite()
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Alex Williamson <alex@shazbot.org>, bcm-kernel-feedback-list@broadcom.com, 
	Christian Koenig <christian.koenig@amd.com>, David Hildenbrand <david@kernel.org>, 
	dri-devel@lists.freedesktop.org, Fei Li <fei1.li@intel.com>, 
	Huang Rui <ray.huang@amd.com>, linux-mm@kvack.org, linux-s390@vger.kernel.org, 
	Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>, Sergio Lopez <slp@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Thomas Zimmermann <tzimmermann@suse.de>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 4:42=E2=80=AFPM Boris Brezillon
<boris.brezillon@collabora.com> wrote:
> Okay, I thought I'd ask to be sure, because of all the implementations
> of pfn_mkwrite listed here [1], only drm_gem_shmem_helper.c and
> kernel/events/core.c do that.

Also the vmwgfx one in patch 3; and for the !DAX case ext4 and XFS too
(e.g. xfs_filemap_pfn_mkwrite gets to iomap_page_mkwrite, not to
filemap_fault).

> The rest have their "generic" fault
> handler (by generic I mean a fault handler helper that covers all the
> order/WRITE_FLAG combinations) called from pfn_mkwrite(), and return a
> non-zero vm_fault_t.

I see; I think you can do that, it is handled at
https://elixir.bootlin.com/linux/v7.2-rc5/source/mm/memory.c#L2681 and
indeed it returns VM_FAULT_NOPAGE. But it's more or work for no real
reason. Your .pfn_mkwrite is a single line of code and it is clearer
IMO if you can see that try_insert_pfn() is calling the same helper as
.pfn_mkwrite().

Paolo

