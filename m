Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AE7405C21
	for <linux-s390@vger.kernel.org>; Fri, 15 May 2026 23:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778888759; cv=none; b=hgprEXmDAWIpfgaxSY3iK5fJmnTGz04hD0QoESVD1ARnTs+94vr+4JFvEysgAwvq3+7xYMj/EdYG8rF5axifoh1nW4djSic9svlr9sPb9yefm0hCm1MiuiGJOAwLrkbgY+C5YEaXY2TRQf3BMXNqZWzPiNWkAud4cP/nZmGd3dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778888759; c=relaxed/simple;
	bh=kDfFFhlbQ9JRwkWYtPQHXJsCxysa9jjnPwXQpLDaJec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q+oU4KfPULhDOD2iKALyDxYlFvs+pN3V6eNOJ5J8Dv6h+7ncGUpajYIyGebeX1OeVjsfk69CKKGU/b7SdHsGRQOvau3EY3x347/qNfri3NST9VjD9PQX1VASO1lUdXsbC76YYFCzbqM+osO61m6naPzTpfRUA0FXk13lc0a+ygA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LbNC54yV; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LbNC54yV"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6763cc8775cso3396341a12.0
        for <linux-s390@vger.kernel.org>; Fri, 15 May 2026 16:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1778888756; x=1779493556; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JnoPlBIHGBifXSZSzBae7mPDjhkTo65UoK8Z/KktsdA=;
        b=LbNC54yVn+q1f66R3AjkqsETg1uDHPIagGrvayl345adiZal/R3yHGN0KRw5r2axyY
         4HGOFyfbPSDiGR1QKPBbkurFtZj/VA8y+i4K/sOo6kKNi2ItBwgdIhnE8oDiGS/kcCJM
         X1pIT9jIhYI8e+6AS1ZtY1byUBWNMN+hem74Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778888756; x=1779493556;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JnoPlBIHGBifXSZSzBae7mPDjhkTo65UoK8Z/KktsdA=;
        b=bz5JHDyDqJAiA1vS65NAUyt3oX5FzPB4sywIf/QBPsdO5W3Pb8rAdJ5BwQ3wuQ2TCp
         vi6nTBNXU843hDikwPLyiO6CHC+sy7XCpHNgkujIr9Ty2+X/Ns9qiHaVKaopmN77DyQZ
         aeFoZWvDIggP/UNy8vJ618QVn1Uqw7Km8qf8rOsmdY4tMW3V2Re8ri+AAARI2e8HOJV3
         2sA8J9Vt69fm0az32P3YmB+XASicJ25WNlt4qIaZnX2pSeaJmGDxy34uyLKMWLiwsdoV
         dOKzWREnixDoOpkILRi/MVAg7Gcwb+jghtBMYQ22s9OG2bM1CpFbGMuBwcrDaM1Kor0k
         ZseA==
X-Forwarded-Encrypted: i=1; AFNElJ/09Y+nRnwmqYMoNF2AAI4DhD1hhvQNkpu+L0LEK75wscVGY3X9lG9ndxSO67kmDHHZ+HtwKOqmYV5+@vger.kernel.org
X-Gm-Message-State: AOJu0YyfCQEJjIb813A+sAzhc8l4+6S9mrRbt18tl7VSwBU6VsJ7/H/f
	IWkmpt+UXP4BTSBnoNw6dFQk8PxOgA7zpheWa5qJfjia/7JkU6tahSkrXc/SauNrfq91WnHHQaJ
	Im2ueYhs=
X-Gm-Gg: Acq92OH0gQUhkzQLgFYh/3peZ+tZfa4aqQk+79K/89lmdLEsZoX0MHjbuyJkNJ7tA0s
	2c/2wanz26dRO+E/T6uAQ1msUZH3/+8xwJ9YAigD+xgJDEmJCaCfTJilmCP9vxXMOa1310RxwFy
	Il++F27H2thHeEXLDdZq6/nMyq+2T1fj0KTOwQY0t5A28qmvoumDwslRm8Kk1K8WRl99I5Du3vd
	G5GU5RfbddyIN7wzZQmOv8bY0heR0pEjtj/RlWF9WFL4+0eLb+/iaKgT9XFHU/LGUb6O3K4M5RQ
	yeW+gREbiW8MaPaw72ZTdAuAk9LxL8GlBnmXVCwAttoptEisp9e8Y2mBN2tuuAtqgWuax6M/fEI
	59EDFBJxZW9VHvIlbz8pQf8PVhXKvIRVbtwEJgYBYMtxzrjEyKKNezqAszWnR0dO9Kr6W4caoqw
	QCOFzzrWoo+EwwmBK+QIUfxuQbD0cXduXwP1H2075C0y16ApwvCi239vl9MF3VfFSxU0P8fzGI
X-Received: by 2002:a17:907:d091:b0:bc6:bb4b:1726 with SMTP id a640c23a62f3a-bd51553a62cmr322848566b.22.1778888756421;
        Fri, 15 May 2026 16:45:56 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4e9175csm275247166b.55.2026.05.15.16.45.54
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 16:45:55 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-67b32c695efso3408470a12.1
        for <linux-s390@vger.kernel.org>; Fri, 15 May 2026 16:45:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8tN5Bed7JuxTfuHYYmxYyJokYqGZTZ/FI6fcfE+X9BXwTK7OkaQBfBx3V7BZoxDcS5WoSftQ23gUNv@vger.kernel.org
X-Received: by 2002:a17:907:c10:b0:bd1:f09f:f819 with SMTP id
 a640c23a62f3a-bd4f34bd039mr495323566b.25.1778888754734; Fri, 15 May 2026
 16:45:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511214226.937793-1-minchan@kernel.org> <20260515-nachdenken-umbenannt-a90006a46e14@brauner>
 <agd--WZpeTq2iKFW@redhat.com> <agefLhQeWpvil14M@google.com>
In-Reply-To: <agefLhQeWpvil14M@google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 15 May 2026 16:45:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiHfzbufXD2nuc9BhOVp-pYEmnVUYeThKmfZRXLU0kJ7w@mail.gmail.com>
X-Gm-Features: AVHnY4ISab34jjbhdpMRq24hfEjl9hP1VDaCyqC4-uWVI2wdpSycH5ojtzu1j7I
Message-ID: <CAHk-=wiHfzbufXD2nuc9BhOVp-pYEmnVUYeThKmfZRXLU0kJ7w@mail.gmail.com>
Subject: Re: [PATCH v3] mm: process_mrelease: introduce PROCESS_MRELEASE_REAP_KILL
 flag
To: Minchan Kim <minchan@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Christian Brauner <brauner@kernel.org>, Jann Horn <jannh@google.com>, 
	akpm@linux-foundation.org, hca@linux.ibm.com, linux-s390@vger.kernel.org, 
	david@kernel.org, mhocko@suse.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, surenb@google.com, timmurray@google.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 15 May 2026 at 15:33, Minchan Kim <minchan@kernel.org> wrote:
>
> I hope thisclarifies the motivation and mechanics behind this issue.

This still seems very hacky and a complete special case for one odd situation.

This all sounds like it's just because smap is a pig.

And yes, smap *is* a pig, but it should be trivial to just fix smap
for this case - fix the problem spot, don't add new horrid logic
elsewhere.

I really think the fix is to fix smap instead.

And I think smap is doing odd things. For example, it does

   pid_smaps_open -> do_maps_open -> proc_mem_open

and that proc_mem_open() takes that long-term ref to the mm. And then
does various memory allocations - and copying data to user space -
under that long-term ref, which is presumably what causes all the
latency issues.

But it doesn't actually seem to *need* a long-term ref to the mm. The
seqfile interface is designed so that it should all be chunkable, and
the locks and refs should be done at m_start/m_end time.

And the smap / maps m_start and m_end functions already *almost* seem
to do that. They literally look up the task again with

        priv->task = get_proc_task(priv->inode);

etc, but then they do that odd

        lock_ctx = &priv->lock_ctx;
        mm = lock_ctx->mm;
        if (!mm || !mmget_not_zero(mm)) {
                put_task_struct(priv->task);
                priv->task = NULL;
                return NULL;
        }

dance (where lock_ctx->mm is literally that long-term ref we hold).

And I don't see why they need to do any of this. I think it's all a
historical accident.

Because I think it could look up the mm from the task pointer every
time, without holding that long-term ref from proc_mem_open() at all.

IOW, at open time, we could save off the "this is the mm I opened",
but *without* any refcount, and then just verify that "yes, the task
mm still matches". No long-term refs anywhere.

Yes, yes, we'd need some sequence counter for when the mm changes due
to execve, but *that* should be absolutely trivial.

And wouldn't that make all of this go away entirely? And probably
clean up the code at the same time?

I think the only reason "proc_mem_open()" does what it does was that
it was simple. Not because it was a good idea.

                   Linus
