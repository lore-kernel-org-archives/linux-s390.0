Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559571B6CE9
	for <linux-s390@vger.kernel.org>; Sat, 21 Mar 2026 05:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774070775; cv=none; b=no8eU6KV1K/MkfL3HkB5Rzb+7Zvky28VTTpNkliApFVVUdQyMMBNVghzyoOv3BrB5sT4b0tOQGT/nzUfQTNbfgQgm54fXkZjT8fo0u41J0RBypx3aFo8dstuNERJFk80NeqX0HMq5zbHad5f6XjP8aVXZ+J7i1N/Ww5PnMVPWOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774070775; c=relaxed/simple;
	bh=f2FGYzER/1NSdCgQbZhD8ESSlUAXZ2pKt8ApCgQs+WM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=NxW4YjOCe24KWKdoKTZoxjTGRHjZ18YA3uYHiEh8UhDrFVwv7oT97tDMPMjn6M3G0sFeBgRZjENRrLfb3gQeYqjfzurcmgSEjnCYprvHz1zFZtb9D8agQIVngCwtyKG5J9wGVHFw+z2yp4yZjaHDcP2WWGX8dEdjEsA+UTJ9ICw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JH7tK+h/; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JH7tK+h/"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-359fea895b5so1781172a91.0
        for <linux-s390@vger.kernel.org>; Fri, 20 Mar 2026 22:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774070773; x=1774675573; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PPum4GWetd7qCwPivtEJVV9TkLkZOn6LkWq6BWUPBjA=;
        b=JH7tK+h/GCvkqOclAJkfhMrLNnUCbGlurtpgwVAkbGKK1NNBHm/oQF8C9109HRu/Ia
         3BTmoFxQJbFkT+enKgHAOzANjHQiFAZviYmTO0k2QqiYuqFM67QIlEM08gSLWXHpVwiy
         GP9l1KjNgOIxnxJnDjDskejG3KU4jeMD5e9nfnpjUkITnG19hhmo2W3tMba61Ri4aPu+
         Da3f3TrARpDb1fYTV8OQdBnpCOgZOgWi7gcUqVd8XQZy/DpbZJV4jaucgDsajmYM48cE
         euMZjG2x+AmEgpquGjThFs6H9mo0BeJ7a9o0fkchP635trdPdJvjzEt+7o8vWw+5iAVl
         Qcyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774070773; x=1774675573;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PPum4GWetd7qCwPivtEJVV9TkLkZOn6LkWq6BWUPBjA=;
        b=f2z+eeL0qmJ64h9wOYYdINvTW04RCFBgUIRtm+foHCpe3XanwiKXYoLidq5UTBrZSJ
         Z9nWho3DhBT9tm4zVu2OsjuRPTneKW1dyjHoIq+mNou6NLEkBufKFIhkCARTSTL+Y+1G
         k3GNexka5+A5WlKMtiU+mRBxjohOHT0OEu6Jk78DjLzX9f+04WxnXkog4rDKhDEyl4ft
         Xbxyc+8MnlZZyFqCSe5coOs1dWJVyvw5MKvOay7WlD7rxmUoWA8oNYhKK4ql7RIgUtZW
         1jw8h6WwS1qxPoYJMDBjm8K9nUJxzIsDLR7JHmSjLlKU9ccGBEjZGz7rUkhY2msf0k3s
         phPw==
X-Forwarded-Encrypted: i=1; AJvYcCWC5nH+/So4Lh1HVcnvqXUifMid4PjlJlEhdJ68cOB9ujW03hcCDDzp8IBC4m2+FN+PnjGUhhlyHla3@vger.kernel.org
X-Gm-Message-State: AOJu0YyovjKzD7ErbhiumUxHFXvPgzN2G24gyBDZXcY2zL19WeE5jMiN
	NSwc+awVmFEdNy1gC3/GzS+rTlAlw50pw2K96mFv0A666iG5HKVW/qVe
X-Gm-Gg: ATEYQzzUv+OfoFc8odhbfZuA7v5JBAeVCg7U8JXA9enVH1UAkVAk7vH2yAYRMxmUs+0
	LMYaECRiLN52paFSB+kKkuObMQ5v7Ap0x3RyUomMujQzsg7xvaD8W6ZLGPHFnYqKPiKY1QTnI5/
	I/o82WhxvrSRqkPZw6y5ZAVUeZnnpmEG0Ap9ZY88EGCYCmcytniLBBmiS40uTiQfsfs1PjCtofK
	pNLuY+RMiOT942JCZ9EDibwA1KPBpm9mkZiLHZ9Sgemx7PAymFXSvP8y+Nv3t+fHeFYv4ELi3ks
	j3rUCspTEhcao0/YHQ8r6RmdK7v5zN/UKBAaOgdV6RJAQXvohyfD7y0UTltrABc8Yh0b/3h5LE6
	ffesoLtYQv79e1WiXO+igSrjM4B6y8frVijqeDPdLBXYMFenjsloi5onu8XDTSb77vxsPAYHn9F
	De4CXUZNxXuplBAHbCuhSSbw==
X-Received: by 2002:a17:90b:510a:b0:359:f3b1:6811 with SMTP id 98e67ed59e1d1-35bd2bd5ceamr4620697a91.1.1774070772650;
        Fri, 20 Mar 2026 22:26:12 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bd41347f0sm3299371a91.17.2026.03.20.22.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 22:26:12 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org, david@kernel.org
Cc: ljs@kernel.org, Liam.Howlett@oracle.com, vbabka@kernel.org, rppt@kernel.org, surenb@google.com, mhocko@suse.com, baolin.wang@linux.alibaba.com, linux-arm-kernel@lists.infradead.org, x86@kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, open <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] mm: change to return bool for pmdp_test_and_clear_young()
In-Reply-To: <8025b898d0841a4bcbd766998959b4e2ae4d4abc.1773890510.git.baolin.wang@linux.alibaba.com>
Date: Sat, 21 Mar 2026 10:54:05 +0530
Message-ID: <ecldycui.ritesh.list@gmail.com>
References: <cover.1773890510.git.baolin.wang@linux.alibaba.com> <8025b898d0841a4bcbd766998959b4e2ae4d4abc.1773890510.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Baolin Wang <baolin.wang@linux.alibaba.com> writes:

> Callers use pmdp_test_and_clear_young() to clear the young flag and check
> whether it was set for this PMD entry. Change the return type to bool to
> make the intention clearer.
>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  arch/arm64/include/asm/pgtable.h             |  6 +++---
>  arch/powerpc/include/asm/book3s/64/pgtable.h | 10 +++++-----
>  arch/powerpc/mm/book3s64/pgtable.c           |  4 ++--
>  arch/riscv/include/asm/pgtable.h             |  2 +-
>  arch/s390/include/asm/pgtable.h              |  4 ++--
>  arch/x86/include/asm/pgtable.h               |  4 ++--
>  arch/x86/mm/pgtable.c                        |  6 +++---
>  include/linux/pgtable.h                      | 19 +++++++++----------
>  8 files changed, 27 insertions(+), 28 deletions(-)
>

LGTM. Please feel free to add:
(assuming you will anyway kill the unwanted externs)

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
