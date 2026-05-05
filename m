Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E953B0AF5
	for <linux-s390@vger.kernel.org>; Tue,  5 May 2026 16:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777996989; cv=none; b=BW/RTQOFCiHlLUnRlojdV/MA+QLelYTCKA48ncVZv8VtzuPGYna2WMCiL0qKFzUaMRy9C3Zz1GmcuwJzzm+tqZHwuLoK10jGu7ryQX0uR6SWthvCDnQLGIeKANGRK7smJBFit8xRceVxxVfGkenx8JrlFwtiyRWHtRg7FMQYIcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777996989; c=relaxed/simple;
	bh=aRfzCmY9fPzX3/OojnI6eIuUWbgNr+IyhRI7InSeD3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a17Ak86R8tUrJCnQHG4YwrvqhQ83kTZ/tz7pNe5++zBPW28G2ryXy0U+7VjzzAyyuyZCKLStZ+G4v7L0XmIfF3GAHWXbnrce8VsfWXhEaxj2RwKlTOQ7Of9SXhRNoveAfDC7wqO+yllKG+ggKWaK1IFYwSaw+U53l9nNeHy5N7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XS8QmHob; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XS8QmHob"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488ba840146so47837985e9.1
        for <linux-s390@vger.kernel.org>; Tue, 05 May 2026 09:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1777996986; x=1778601786; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I5a0fHBP8h2hhTJGmZHgpaYcDEY9WIm8IJ7LEnVJOtY=;
        b=XS8QmHob5rebISATLyQjE1/qEHB9UwAvAEsjDlBscdTWGCqOlMLbP0hs8ilcmULud1
         8kc9nTPLsNEWO1ZS0IG2vwiza8n2ys+yEntFm6Jot7hIcXj0mrWD7Poq680mmEWW/Uud
         +Pz7X7QUbx2wqUelKizFtygPd1pUzV0uYMSpGcA21+Qy6rY9fOlXcew376SqXe1hsjUg
         UdJ29mi8Kcj79VjIxkVK607l9usx+rrlW+qCFog33rhGmS3X/qXwv7GeWO61JPSaSNwT
         4i7PBhJ7a5zZirtJOoHVIYR8nLS5CQVbrGZPhMzAQtuR5qKveOeXYl5nrNJKvSyCvHUV
         gawA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777996986; x=1778601786;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I5a0fHBP8h2hhTJGmZHgpaYcDEY9WIm8IJ7LEnVJOtY=;
        b=CTeMDkQ52o37eXZCSdKU669y8WQBWDsLGoOGEPwhCvdTCwOIZCoMgiTj6nnDrDlB0S
         9Sem9IXYQ5Sdy0pwNQ15wWktY6x0Fcd38TcHj4UTWQqcPhDSSF4rAV3ysPMFYkOqesE6
         p3tSfQFH3/L7zyLGKdX/hixq2zZzoLVL+jDP8/fpgwiT/ttlZQwq/MS+R1QtwgD319jv
         ZRx6Z/88rqyUD4exSi6eSSc7D/taiAPDoNFaORtKc/O0b8WU9n750tyeEmohRbvmo4lx
         Qq75jivogrPzd8a+VIMytbpyp3IXCwK+5+yNAtL0wKW7/xKOIbmfyE+pHF/7Yvri9YXs
         Sy2w==
X-Forwarded-Encrypted: i=1; AFNElJ8FGLYoIySJyE/f/XnOY1Rh30KeOC8eTbpRofPtNr3KtSt7yWePipxsjuC5yiua5PJPJtXMtxP1XsCF@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/3LS8N1mQZynaa4GkiLqvnewYk5ol+6rxPAKyOsNu6ISA5G+3
	NYjGtpbSsD43bfAeSeZMjX8y4hqYX3u1sH/dQDWwePH04mOzQYj4XMyHOKx4x8b3fqTEVkFgUhY
	KefpAa8A=
X-Gm-Gg: AeBDieuIG6I116+ostifQ/Y2fVRdgSBscHg0Vm0+yqonABd7KKSYiKlqdCb2HNYVypr
	tbOcIXFvV6+AivTn1S9wRUUekE9TROrXowNJ7bwS//H6w9zAJswJ3bOm/gZdHEnTopoi1Hy9R1P
	eewwvDDDMQvEOUqjCU/SUJL3A/OIWZidbC7QOuxX1z7FReYQ21NgOIuRTXxEli33xIzQjbludzT
	l0bMxF0GtUBiXc/Lpb0HFSMnhMHcm/AnbOk7hPI1oYDMhgGM6WJOk7G1U9se+ivx7gQ0dkYUKIk
	jLlXfrvsGLb2VQlr8zapG1NB7l8YwqCGUwu78xOPkixeBsh6o1umk7xO9mR3vmNceVkzWJszGCD
	tgNCeOseHlyQGMocLgwois/GduVit5noh6sB/glqgaZ8Uk3H86tknL6jhnuZjln1gxA2vHIpY8V
	oUqMEdp6gMP1yB6dNvRrhLrFz6A2aGNdN/mgTOtdLZlAZDgNQ=
X-Received: by 2002:a05:600c:8719:b0:485:3abe:ab86 with SMTP id 5b1f17b1804b1-48d186dc7f5mr65697625e9.4.1777996985939;
        Tue, 05 May 2026 09:03:05 -0700 (PDT)
Received: from localhost (109-81-19-134.rct.o2.cz. [109.81.19.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48d17708195sm33216595e9.3.2026.05.05.09.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 09:03:05 -0700 (PDT)
Date: Tue, 5 May 2026 18:03:03 +0200
From: Michal Hocko <mhocko@suse.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Minchan Kim <minchan@kernel.org>, akpm@linux-foundation.org,
	hca@linux.ibm.com, linux-s390@vger.kernel.org, david@kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, surenb@google.com,
	timmurray@google.com
Subject: Re: [PATCH v2] mm: process_mrelease: introduce
 PROCESS_MRELEASE_REAP_KILL flag
Message-ID: <afoUt3te1k2TNao-@tiehlicka>
References: <20260429211359.3829683-1-minchan@kernel.org>
 <afMnKrYT0xG_a-b3@tiehlicka>
 <afUYfpwWsUQoB9hz@google.com>
 <afhQB0CWEcflXpOi@tiehlicka>
 <20260505-wegbleiben-deshalb-f929089dbdab@brauner>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505-wegbleiben-deshalb-f929089dbdab@brauner>

On Tue 05-05-26 11:30:22, Christian Brauner wrote:
> IIUC, then the OOM kill if invoked from the kernel just takes down
> without permission checking what it wants to take down. That makes a lot
> of sense and is mostly safe - after all it is the kernel that initiates
> the kill.
> 
> However, when userspace initiates the kill we need at least the
> semantics you proposed, Michal. You can only kill processes that you
> have the necessary privileges over otherwise you end up allowing to
> SIGKILL setuid binaries over which you hold no privileged possibly
> generating information leaks or worse.

Agreed!

> The other thing to keep in mind is that currently pidfds explicitly do
> not to allow to signal taks that are outside of their pid namespace
> hierarchy - see pidfd_send_signal()'s permission checking. I don't want
> to break these semantics - it's just very bad api design if signaling
> suddenly behaves differently and pidfd suddenly convey the ability to
> do a very wide signal scope.

Agreed!

> The other thing is that pidfds are handles that can be sent around using
> SCM_RIGHTS which means they could be forwarded to a container or another
> privileged user that then initiates kill semantics.
> 
> The other thing is that the type of pidfd selects the scope of the
> signaling operation:
> 
> * If the pidfd was created via PIDFD_THREAD then the scope of the signal
>   is by default the individual thread - unless the signal itself is
>   thread-group oriented ofc.
> 
> * If the pidfd was created wihout PIDFD_THREAD then the scope of the
>   signal is by default the thread-group.
> 
> * pidfd_send_signal() provides explicitly scope overrides:
> 
>   (1) PIDFD_SIGNAL_THREAD
>   (2) PIDFD_SIGNAL_THREAD_GROUP
>   (3) PIDFD_SIGNAL_PROCESS_GROUP
> 
>   The flags should be mostly self-explanatory.
> 
>   So I really dislike the idea of now letting the pidfd passed to
>   process_mrelease() to have an implicit scope suddenly. The problem is
>   that this is very opaque to userspace and introduces another way to
>   signal a group of processes.

I do see your point. Unfortunately the whole concept of mm shared
across thread (signal) groups is not fitting well into the overall
model. For the most usecases this is not a big problem. But oom handlers
do care. If you do not kill all owners of the mm you are not releasing
any memory.

> IOW, I still dislike the fact that process_mrelease() is suddenly turned
> into a signal sending syscall and I really dislike the fact that it
> implies a "kill everything with that mm and cross other thread-groups".
> 
> I wonder if you couldn't just add PIDFD_SIGNAL_MM_GROUP or something to
> pidfd_send_signal() instead.

That would be a clean interface for sure. The thing we are struggling
here is not just the killing side of things but also grabbing the mm
before it disappears which is the primary reason why process_mrelease is
turning into signal sending syscall (which you seem to be not in favor
of).

So I can see these options on the table
1) keep process_mrelease as is and live with the race. This sucks
because it makes userspace low memory (oom) killers harder to predict.
2) we add the proposed option to kill&release into process_mrelease that
is not aware of shared mm case. This sucks because it creates an easy
way to evade from the said oom killer
3) same as 2 but add PIDFD_SIGNAL_MM_GROUP that would do the right thing
on the signal handling side. You seem to like the idea from the
pidfd_send_signal POV but I am not sure you are OK with that being
implanted into process_mrelease.
-- 
Michal Hocko
SUSE Labs
