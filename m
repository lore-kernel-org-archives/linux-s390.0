Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C119374178
	for <linux-s390@vger.kernel.org>; Tue, 17 Feb 2026 20:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771360309; cv=pass; b=Mk4fggod3Cp9PDhjWKHWmjPVH+EEnOSeJo5lYrGESEvnKXKAOxXIYll+LvDXcN12Cs7dsU+F9xL5mFSXarN1zylKOe0D/LuLRMu1OWgJk8NqOdPCTMLw9vPdUgjHulISstn1gtpdJUsrbpKchjo+Dw6TZdeWaZhlHciaOT9vlbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771360309; c=relaxed/simple;
	bh=O6hX9dg3oPdI5w6wnUKEspXcKuxPryEjYBIewl5phQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HEZI1lP5HMNwwF1nugMjBA96MEUtVLsFXbtte5jFcDs/nIDmcxd/vMVjoV5VkFbJvjiVGpYnxyHTyOQLGxAjuQ6DgE23QBAOIRLxSc5s7u+b7MrqUd8Rk3WmFShnz8pYCVBaks0+QzAfNmgZOR4KHJU7UqHOjjiEJzQDrKB4zpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UeVHbMib; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UeVHbMib"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5033b64256dso128451cf.0
        for <linux-s390@vger.kernel.org>; Tue, 17 Feb 2026 12:31:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771360305; cv=none;
        d=google.com; s=arc-20240605;
        b=lGeBuuY/ywssrZZMLRnpjtCJG629QLBwXGYMeRwtHD3Nz+YaUGS9j2KeuJsZRUsqbQ
         JGYD0TCCnlruoPm0/VjxFNTo8VgRM+Ep8pkR8KaqkXnttIw7Zp04f26F4043nM3cqSPC
         v4jvp4+uOL5MrrVfRjGDs8YSu9cg0p25rBpYGWX+cFz+s3m60qAWPFACEGQ9pxJFXmPJ
         4GfAWJ44FFbA7kJG7dbISYxD5lQ3uGlIbhFYuf7WSknyckxwIrfaMCr35ApfTsoknSj/
         itBubimoSQR9UdM3u0P+8+WV0jrGiAtUNmeUsBooH7R8xTDDhwKk1TicSx8Z9TmsbBG7
         HOrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bBuR5hoi+JIoThnLErWVLc3d8raQLXMxIFo7dRHtl7Q=;
        fh=sivEvNsCjDzoTOoxAM6XkcSSoMCLMv7RU2/XZuEipUo=;
        b=SyWUmLgmZLCdnsG0qAMcUhFfRpvEZGpvGrPpP8o2hEbuGlfalPZ9+UoDVV7mwAouKv
         kXylUaFzaVpzIYsvMO3DvVXMc7X7CP9/OWiMIfL9C+vqSg2AWbHAMERbOjqnild2+UHa
         yYbH3dDrYtizAMHfZK7uL/ktt84CKllkh5hNgdzfd7V91QRBuFnhfOHrrtDOQOOUD2eq
         A41Y2qWsEM8D5azquWoRONM3JkZrKCr2plk5B0MDTLBAZGfQkt/yGAgqkkfRMPMATnJ8
         gR0xldtzzBPUj3nDfRgIeI2VeFa4fMVu0jO8yW6Vi96k7zDzTCIbA0ITsbDr/zogqaik
         87Cw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771360305; x=1771965105; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bBuR5hoi+JIoThnLErWVLc3d8raQLXMxIFo7dRHtl7Q=;
        b=UeVHbMibqOfRQKGYKAh/WRjskzuqNuGewj5Dj+apgjsEjuBzhDfIsnD23PEgJpxicM
         GtonqZ79YXpeGY7YZxuPk5TAKfJ5zKwhPYQNR7+GnsUNiPcyjPuJP3FeMnOeZBsw1y7k
         Vvt0YJa2del8puxvK+dDnZ1T+/jW/QRN8clTbwfu2YpUHi4vqt1e2iporg7aAZ/a9hZ8
         aqXSRBOk+KR8TmyjmhsJv2TILjh6GeofkYID3UaiKqw8fYq1He+zNTkQI6wDkal3kkbd
         Nqv+R2WaJunaw5qubIBhFRLpLYiI6cKaUpKBugcN9Gtz6FSBw9Qth0tM0EbtJdcKcB10
         UvIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771360305; x=1771965105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bBuR5hoi+JIoThnLErWVLc3d8raQLXMxIFo7dRHtl7Q=;
        b=gmn1HIdXqaLzZJ4gYup0z2pGjYaq9eIwZuUnGC3/PdsiGFhOzkZDeKkpL6yGjBDMDQ
         l1Op9BJyqNKMGkUKiImQZuDo6JvzhEmQs3zL5z7TOvbENrYQN3QfAqe0W5qR7mfnsiDw
         EJJbVnLbu93TOUDuVp5wbfLp+CQfaN1c/dym5JhmDHEhP2vTRCjUBBZ0sVkqoM14udnz
         3QGw3HW4MAhjSl4+90LaKxMibBUJbS4DwzrCnIL1gXKkjPQdSHWrb8qDab2WhoRBgDSa
         plC9muZkQ1YMO76y/k4VJNc6Skvr+A3/bv6lUTIG+R5tdhc7ibOLUnoeTEnemqX663NS
         OY9A==
X-Forwarded-Encrypted: i=1; AJvYcCVDr2s+OYkd55eeFfawuMPScagHxSoK6a00VeU/feEO32/P2yVWnHdzyeFll+ofXr//27jmqJ2H3O9O@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1jPzdzIxZrSasoJtBKR7aQst34ZabK7LcsliKqXDYmGrSK6io
	UsQGHBQEdIZk8NGKaZx1cVvJCtfpnd/veS7AdLxojFgodDNXsflh/WMVlmplpgX27QRdIAhG+R9
	AamfIFRpbGYyul/2yWsmBilSi19ScML+euPV//NsS
X-Gm-Gg: AZuq6aKy9OVWFi8O3UwW+CZUUhqWmblNSVN8N3phJeQ/gYzTj/dUIITKSiX0XrU0Xpx
	e5bx1cvdVCNNv6u3mWgcSQcXj6moebmMHtXk2G6+/osdLVs9ShlngHzjICV6nbqrHJaGbRSlTgm
	VVXNGVgE6yDUsK9jvaVWuaE2UcyjKMCMfh90a4TOYnC4YTciE9Y17rRwV7NOILEpc42FOv5dzLX
	RHVnLupGZx/dqSyaynCdEbhLOaz5lWpQ/+n8g1ucTnbTUpE/TN/1GHtObM//jLrNmoPkqvW+TUU
	Ky8W6HjuD5UbMYAEbSzZNnsTHtHGarBhkWyOMg==
X-Received: by 2002:ac8:5746:0:b0:506:9852:75ec with SMTP id
 d75a77b69052e-506cdb4c09cmr21741071cf.9.1771360303253; Tue, 17 Feb 2026
 12:31:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260217163250.2326001-1-surenb@google.com> <20260217163250.2326001-4-surenb@google.com>
 <20260217191530.13857Aae-hca@linux.ibm.com>
In-Reply-To: <20260217191530.13857Aae-hca@linux.ibm.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 17 Feb 2026 12:31:32 -0800
X-Gm-Features: AaiRm503YYR0kTgCvbJHDicLagxX0QqBNRpofu84bYZnAbv1-xnaYHyLZPIeE6k
Message-ID: <CAJuCfpGxsX6kZAzZJZo7aGNxEbeqOhTV8epF+sHXyqUFOP1few@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] mm: use vma_start_write_killable() in process_vma_walk_lock()
To: Heiko Carstens <hca@linux.ibm.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, david@kernel.org, 
	ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net, 
	ying.huang@linux.alibaba.com, apopple@nvidia.com, lorenzo.stoakes@oracle.com, 
	baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org, 
	lance.yang@linux.dev, vbabka@suse.cz, jannh@google.com, rppt@kernel.org, 
	mhocko@suse.com, pfalcato@suse.de, kees@kernel.org, maddy@linux.ibm.com, 
	npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org, 
	borntraeger@linux.ibm.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com, 
	gor@linux.ibm.com, agordeev@linux.ibm.com, svens@linux.ibm.com, 
	gerald.schaefer@linux.ibm.com, linux-mm@kvack.org, 
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 17, 2026 at 11:15=E2=80=AFAM Heiko Carstens <hca@linux.ibm.com>=
 wrote:
>
> On Tue, Feb 17, 2026 at 08:32:50AM -0800, Suren Baghdasaryan wrote:
> > Replace vma_start_write() with vma_start_write_killable() when
> > process_vma_walk_lock() is used with PGWALK_WRLOCK option.
> > Adjust its direct and indirect users to check for a possible error
> > and handle it.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  arch/s390/kvm/kvm-s390.c |  5 +++--
> >  arch/s390/mm/gmap.c      | 13 ++++++++++---
> >  fs/proc/task_mmu.c       |  7 ++++++-
> >  mm/pagewalk.c            | 20 ++++++++++++++------
> >  4 files changed, 33 insertions(+), 12 deletions(-)
>
> The s390 code modified with this patch does not exist upstream
> anymore. It has been replaced with Claudio's huge gmap rewrite.

Hmm. My patchset is based on mm-new. I guess the code was modified in
some other tree. Could you please provide a link to that patchset so I
can track it? I'll probably remove this patch from my set until that
one is merged.
