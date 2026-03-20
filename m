Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0382D592D
	for <linux-s390@vger.kernel.org>; Sat, 21 Mar 2026 05:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774069875; cv=none; b=aq4sJXzrhSgid/BWgzPuPTRZ6E3cFuo5GWKvcOs1vr4+vmotEQMf3FWZercdUo9iXOP0IA2rZEAzcO3Pz8m21dYJmGzrqQUnXUgZ43ufsZDCtXFX7PzdKLZ3chIOPJ94JjiuyXdmKOYUVvmgjQt8cZ477y5/ZoZQj2aRIrd6Xk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774069875; c=relaxed/simple;
	bh=qVwlCu1WIXntn26q1kvsy4ns7XCLQh3LUnFd91zRr48=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=N+1cvW0vrAstbfbWH+/6sFGXOWVzarsuR/OBHrJGFzLIWGl3X33fGWdV0dyiVYpvpa7VpFRA6AFDylttRjgc6sDh9MbR2LWc6r8qn10iuDA5NlUJrexkjwpyYW3yxEcI9FNoL1/dE0u+68YWf4yhcmPL6jjezXiFOn+K9BnmxsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OLe7OxhB; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OLe7OxhB"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c7412b07f22so1590105a12.0
        for <linux-s390@vger.kernel.org>; Fri, 20 Mar 2026 22:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774069873; x=1774674673; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7QxDv7wA5vy2wx/iALi99txiEfbwQ3ENlpnWZYhHz0A=;
        b=OLe7OxhBzFwMPIltVknpGrXU9DN7TZFVr3dJDvog+FEKXYmG+fHE2bFbgoZCuFCuw2
         0eJIPaT+MwpkQBDn5zFbJSu9h2HQa0J7qzB1ZsadIyJ8Bau/FOCcW7WsotI/JazwbOwC
         Liacvp0OhfIMtoPN1/bsxA1AetNrt12rxXcHel3gly35cWWZocy2wqHD4vswnXxER4SK
         TKXch+jKp5VDm59qDJg8ua+0OqFS8JstiSXF1Pwy5A8Zcue6JB5wdTTc5OSZOMyh9cCw
         BYWG4YhdCWoTZ4G1qzRqr0iGs0BgB00W7fAJFkySqVoTIt3dNWFPgkagFcG568A1/AfF
         xj/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774069873; x=1774674673;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7QxDv7wA5vy2wx/iALi99txiEfbwQ3ENlpnWZYhHz0A=;
        b=aqFY2uDc0W9W9a2AsqYO1lLoaUcigeV6aOIhgaBFQxoq3JUypRFmWs/W1ehowRmb+Q
         XoqZjPwIw5ZKl6X8nQdbQM1ceYcJYKsD4xKbQRI77Vyh1Djmwj4j3ltacoJZMA9iDs94
         8rKcUKvFRxQjvIGptGKNi0mWcmK3y5d2rPvWs3IbkdrCWeZDRXL/5kKCx07QRLVrVOjn
         DX3DbenMPPHHRNqzZ18Djgu15Jcq+ug7ndJfwV+DgT/Fh6vNbTeLc6hBLLtgdbBQkikT
         dFPHfJiK9S5mTtms237sj00lr1cxFR80KO2NVAA10kI9zpYDI3hXQ1TkTRA8Zj/4k7bT
         g9Uw==
X-Forwarded-Encrypted: i=1; AJvYcCVauZk0ZvO8uLsD5s1fAnYh5+SDACP1GRdkPWBCYBINs0krel7ZRDw8N7Nvx6xwdE2+YN0OI59NFshg@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5AYsyhJQqbpvApAENaoDWTF6uQwvyPPQIOzHs9uK9oScIdQa7
	/zPvcAMh1YDOd/k1wLHzH2BPsFs8Bw9mT5h7exzeK0CnA33+kqW+kGo2
X-Gm-Gg: ATEYQzwrCjLAo+LM1nyAM/tIjkrEyw5pChBt8h6MrnLiIldBkU3rSrXAHZ6JtEIChRQ
	tZThYK6g2rdrckbkGHiGec44iMEhOjsGkC8L5Pc12b73uTk7bvdiYVmSkIn09dJcuTqXpWxivU2
	gFRXzzol1kRwYXBrS/grFLgUpdIxGUR+L5helC9Sjyy77XUnhfYj5v3om+KAygc3Fi5dfgcBJs9
	Vb8bd9DoHDksYZm0ozyIrIiGsjYyAi0LGvhrid0G3FUNx3F7E/hQVJ47n4yskYV69IUHauLwm3a
	0krOdQ5XxBTzltdR2cgcmTVgavA//zCjoR2KvvIyHK189VQKtt/Yiw0yN6V+hGfhbl3WXhf5Ct6
	3lvwgFHstHMELvuVCZsOpuRaSmvxyisrREJiqRDDY/7z6zNAuVmqyWnRn4MNULWlG+0RADiKvvX
	nXGySAuFunjbVZlKuiDzdCvw==
X-Received: by 2002:a05:6a21:4cca:b0:39b:9c3a:f54f with SMTP id adf61e73a8af0-39bb25e7511mr8216718637.32.1774069873215;
        Fri, 20 Mar 2026 22:11:13 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c743a939af0sm2729778a12.16.2026.03.20.22.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 22:11:12 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org, david@kernel.org
Cc: ljs@kernel.org, Liam.Howlett@oracle.com, vbabka@kernel.org, rppt@kernel.org, surenb@google.com, mhocko@suse.com, baolin.wang@linux.alibaba.com, linux-arm-kernel@lists.infradead.org, x86@kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, open <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] mm: change to return bool for ptep_test_and_clear_young()
In-Reply-To: <3fa94c3c89fd93fe22c8cb59967f064787d686aa.1773890510.git.baolin.wang@linux.alibaba.com>
Date: Fri, 20 Mar 2026 11:27:48 +0530
Message-ID: <ikarxctf.ritesh.list@gmail.com>
References: <cover.1773890510.git.baolin.wang@linux.alibaba.com> <3fa94c3c89fd93fe22c8cb59967f064787d686aa.1773890510.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Baolin Wang <baolin.wang@linux.alibaba.com> writes:

> Callers use ptep_test_and_clear_young() to clear the young flag and check
> whether it was set. Change the return type to bool to make the intention
> clearer.
>

Right I checked all callers of ptep_test_and_clear_young(). I agree, we
only need bool here. 

> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  arch/arm64/include/asm/pgtable.h             |  8 ++++----
>  arch/arm64/mm/contpte.c                      |  4 ++--
>  arch/microblaze/include/asm/pgtable.h        |  2 +-
>  arch/parisc/include/asm/pgtable.h            |  6 +++---
>  arch/powerpc/include/asm/book3s/32/pgtable.h |  4 ++--
>  arch/powerpc/include/asm/book3s/64/pgtable.h |  6 +++---
>  arch/powerpc/include/asm/nohash/pgtable.h    |  4 ++--

I looked at it because of powerpc changes, but ended up looking into all
call sites anyways. So overall it LGTM (and I agree that we can remove
the unnecessary externs from function declarations)

With that please feel free to add:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
