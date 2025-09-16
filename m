Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC3F29ACFD
	for <linux-s390@vger.kernel.org>; Tue, 16 Sep 2025 09:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758015727; cv=none; b=O2F4S55UZe1RoByEED2Q6uxmfT2LoKD6DpNQ3IQK4JCmJBbZaBA6v9AFqJ6GFzjz43yityvwSwUUFAZozdo6j3GnYsEdbNceKdzNUrJ4ov/e+gd5XLixPQnKxptphmGSuAfQm19dXzkcqAQNAf1mH7cfLll74hgjUTZgLlTH8Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758015727; c=relaxed/simple;
	bh=wtSv0L6/GwqZZywYhmXmG694rGZXr5C/8JsbMi/MtQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UAzknHM83w3J/Qd1RxMNVcKlsw9AnA9jCgSL3Ze2WWJ6A4Ovo44veGmG91pPYXObDCHEtGNt+UAcHX6JGolIOqUXcU4Hw1D6fqw7jb+adqc60mo8U11FIpMBIlGH3NLs5pgtW+4ScWAZYhnp6CoL9GndtcY0y/Jn+g/XAxHbROM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NROLxOU4; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NROLxOU4"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-33c9efd65eeso48951601fa.3
        for <linux-s390@vger.kernel.org>; Tue, 16 Sep 2025 02:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758015724; x=1758620524; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=haBjQsvE5vE3ZaF/RXUldLy+CB1Z0cpROeB+NEV/yO0=;
        b=NROLxOU4z9V4kypeFZVw3XwLvlvgr7633NM1a03un3CtR4lJaMlWQe4MQ9UCfQlvEb
         6ob7dt32cZ4IpbAOwNI4qTzia9lGJazUfcNRQp/OvPUSDu7sGMuWeYcpArVUzIW4p20/
         gKtwWEXsjbsLeP+PHDVCpBxenDK1C/PGey1OlckTGwKYRad5H3S3uYuXCz0vu8CDIW7T
         egPW/KGCxW3n6bStOzn36fCBk211k/YGoekXP8VanV1j1gkifMzn/eUrtagsp5xDC43J
         /jMULwG82ttCurMTfCNleWqTU5QOCkSM5vljU7z/8VsgANXljSZs6vhM5Asl795xTzI1
         suEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758015724; x=1758620524;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=haBjQsvE5vE3ZaF/RXUldLy+CB1Z0cpROeB+NEV/yO0=;
        b=V2P50MelqFIWLh93VoboxMYf5I7ysgAD8MX8kKUoc6ga8VZLB1C7deNcT7mn3lcfGS
         i5hMobkN3azFZW713lf+4/deZL38JE1dH+tZg8zUUPfDcrzVk6qkyW6sUnxGjKv+dtic
         JOscBUKpuvpmrWhYWp33uz2GdDF/O6QObfb7RPFYbsgaGFLlfSrqQfjoX1ZPjWlAOoSD
         JnaTY2/qbAe5ADJWRb2c/xITe1GhCMrCTzhxMnjCTsHZklg0ekM16p+euugXErLW8xEc
         9mApQ6/2T/q+x2NQ7oBCtJtUeTunvy0tqMwfkNeJ163sAj5mBepEVfQvAi8NPTLGe+Df
         S6+g==
X-Forwarded-Encrypted: i=1; AJvYcCXzjy6/3numAslfR33RejHm4NaPKleKrO2ndY7MTHVdQ0nGMb5PkfezWIzlcoaeWvEXDXNzoWS4wZnH@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ/YQj7X7IZ+htHULk8mHKdfpY2k5sG5z4cCKVoIX4EXC5KxZb
	ARMpECGMbFXvIcxvPSwEQiifpg/L/WSCVyh1NHlWJkpciELiRtY8wcOI
X-Gm-Gg: ASbGncsFKHPo0ju0uaSUW8IuiSTvadS4iIOVObzv4PcZKXhnaPBDkuurchmLmtchc7h
	Cw/aA9nCTvC2hFu7NzGkUP0HRpLGrCH7Z1oxe/PMZqXP+vZ9uaewlgVfeXRX5pfxm9UxCGzjyGz
	FpqFQrWZ4qEwEuGkWtJf6+JNOhtsQ4S6SQdeLGP0Rrrbd5UJjr7D+S1/tsTPsnmHu6aAX2qqVRx
	UX3Qjj4gLAy+dn85fUOO8VddttpBx7vAhQbqWHvxDXX0Xrp+Vw9SNSZzsxy6/4onZP6QUfUSmj6
	57qDAtpt0MAeHt6sC0b0S30a2iHE/aSExmWRDJ9f7mwa2j0+iEtuJmdfF6jvRvDwBzGlc1K2NLR
	V2Zv3E7e+r9dsGjwkCjbwFzJ2IPMizh2qNMubjRyCR+Xy0nE=
X-Google-Smtp-Source: AGHT+IGHsAz1XUgqjX9cBNXDDceT4RSYaRrx53ol9Kht+YGnRRfTcQN5imeqv3DeXohNMYqhdx9Bfg==
X-Received: by 2002:a2e:a00e:0:20b0:34a:7575:36db with SMTP id 38308e7fff4ca-351401fd0f5mr48965051fa.33.1758015723646;
        Tue, 16 Sep 2025 02:42:03 -0700 (PDT)
Received: from home.paul.comp (paulfertser.info. [2001:470:26:54b:226:9eff:fe70:80c2])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-34f15a5835asm32481881fa.4.2025.09.16.02.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 02:42:02 -0700 (PDT)
Received: from home.paul.comp (home.paul.comp [IPv6:0:0:0:0:0:0:0:1])
	by home.paul.comp (8.15.2/8.15.2/Debian-22+deb11u3) with ESMTP id 58G9fwKw021585;
	Tue, 16 Sep 2025 12:41:59 +0300
Received: (from paul@localhost)
	by home.paul.comp (8.15.2/8.15.2/Submit) id 58G9fts1021584;
	Tue, 16 Sep 2025 12:41:55 +0300
Date: Tue, 16 Sep 2025 12:41:55 +0300
From: Paul Fertser <fercerpav@gmail.com>
To: pengdonglin <dolinux.peng@gmail.com>
Cc: tj@kernel.org, tony.luck@intel.com, jani.nikula@linux.intel.com,
        ap420073@gmail.com, jv@jvosburgh.net, freude@linux.ibm.com,
        bcrl@kvack.org, trondmy@kernel.org, longman@redhat.com,
        kees@kernel.org, bigeasy@linutronix.de, hdanton@sina.com,
        paulmck@kernel.org, linux-kernel@vger.kernel.org,
        linux-rt-devel@lists.linux.dev, linux-nfs@vger.kernel.org,
        linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, linux-wireless@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-s390@vger.kernel.org,
        cgroups@vger.kernel.org, Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        pengdonglin <pengdonglin@xiaomi.com>
Subject: Re: [PATCH v3 11/14] net: ncsi: Remove redundant
 rcu_read_lock/unlock() in spin_lock
Message-ID: <aMkw4zTLRJqpVGCm@home.paul.comp>
References: <20250916044735.2316171-1-dolinux.peng@gmail.com>
 <20250916044735.2316171-12-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916044735.2316171-12-dolinux.peng@gmail.com>

Hello pengdonglin,

Thank you for the patch, looks reasonable and justified.

On Tue, Sep 16, 2025 at 12:47:32PM +0800, pengdonglin wrote:
> From: pengdonglin <pengdonglin@xiaomi.com>
> 
> Since commit a8bb74acd8efe ("rcu: Consolidate RCU-sched update-side function definitions")
> there is no difference between rcu_read_lock(), rcu_read_lock_bh() and
> rcu_read_lock_sched() in terms of RCU read section and the relevant grace
> period. That means that spin_lock(), which implies rcu_read_lock_sched(),
> also implies rcu_read_lock().
> 
> There is no need no explicitly start a RCU read section if one has already
> been started implicitly by spin_lock().
> 
> Simplify the code and remove the inner rcu_read_lock() invocation.

Reviewed-by: Paul Fertser <fercerpav@gmail.com>
