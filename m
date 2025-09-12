Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0104B335BBC
	for <linux-s390@vger.kernel.org>; Fri, 12 Sep 2025 21:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757711597; cv=none; b=F9/PCsf6NgqkzUHO2BXmJlQoWJj5bqf5bsfqbdBnhb9xc2grR/j2MOlv6bB1oVhmEhX1/8WClfktOfLtbnOEXGqJvcziiliYYLC2oGlONLU963+07/2Omal8lSq7me2X63vp7DdDXSQx7UOrZ/KgDBO47yeQcpC3VMzuynmL1YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757711597; c=relaxed/simple;
	bh=gcaCtOTSXV2XbJKiE3q73MLyt7PVw58fJiPF6uaIJog=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Cczb1Ub2NYFq7ujuERAZhfIJdibSPmCcDN/ePI7Z10KalLuWa0rDKqYqHqid0hjjXikQCTxey32yhywfV+9uQYL4igiTOt3xTDKN4YZIyQYkeSjEljTPjzGGxdGSkIDd0xFP7gl4jyE6de92HWD/kkl/e0sawibOmLYpEjlpVEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BNmb4SFh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BNmb4SFh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757711595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=puZ5qQZ4d8umwYGFpsrfF5AtoSoF7QsuDi9Z2wL5SwM=;
	b=BNmb4SFhg5vtKEAZ2u88geYPbXKfOKLXJSc/lcuuSvdflUl61PxqRI+oUueNbUTRdcewi9
	xMCzqSBsrFKAmDmf/RonyTOgORuz5Oud3YJzivIxr1JiNzhhEH9Evm5/HsIvBr+Hf8rmWX
	SvptbA9Q/ZYEbEmcORc6zuPZlqIvKQI=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-IBuU03IENQyoBJ2Jz8bcOg-1; Fri, 12 Sep 2025 17:13:12 -0400
X-MC-Unique: IBuU03IENQyoBJ2Jz8bcOg-1
X-Mimecast-MFC-AGG-ID: IBuU03IENQyoBJ2Jz8bcOg_1757711592
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b345aff439so68471911cf.0
        for <linux-s390@vger.kernel.org>; Fri, 12 Sep 2025 14:13:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757711592; x=1758316392;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=puZ5qQZ4d8umwYGFpsrfF5AtoSoF7QsuDi9Z2wL5SwM=;
        b=KGzYSu5Ykw/Sx329WP8TrlQlo0k8BSO+D+IjOe5TVU1jdokHUPyHdegwPyh1sX+pbP
         EFGT+wmD8HIaGCRdtj/DU2M2e1Kj/AWtN4J0KgFuj2Nx/TIaGi6wlSHdD4DT3RbIeB57
         BvE6j7+8V4FWTrFkvzzICi/1hHSUlUwjJFaISRv+TBZzLVylnq5ieWPlN6TEqGxHa/gd
         EEKu+u8ARhkIv6wgZHG5eQWbh3td8D3r/DvQlcPlxgwaUnd1WF4sV7AP2WlJx0YfNLje
         rF2Shf3f4/7H8IQ+1RjAbjeOnHB0lZDM/fUw33VSuRc8sU7/fnv8YFlW7y+1ESsVwkB9
         7uTg==
X-Forwarded-Encrypted: i=1; AJvYcCURfYXx1RuVLZ2dyT9Ja0QGnUbmd9NCZqTdY1bffpzD1Cy1Ap9tyy6MnQGK+zb9aSX/8ZOZOEcjM5uM@vger.kernel.org
X-Gm-Message-State: AOJu0YziqZrggZSuPLjdbKvywk2P6jqu7CCePop5bLBtHWQ1dqvcBoqI
	Uxzjw8zeo7Ic/l/mbn4XdNgNoV0rx/QmlgvqN5HgD78dI2m20m4Essm5nLtTgL0sdZ9ab5/k/fk
	7BIM0RXkF3rj4UeyovQOda2eLSxg9WcuSS7Tj9WoHucQ5GqMtTxGnLqhyRSPPQd8=
X-Gm-Gg: ASbGncsNCS8qlVyekUgRz4jZX/agFXcm2BSANneVQhDCEKrtkhqwe5CpnlbEUz0iynf
	lH0DR+b/szAutKg36nSRKP5JRrp3HPMfqVEw+IVWriAlDwgudKQTekE7XbqwLLQucJMd/GY+fGQ
	fXlJsBls3g7KyaELFbzCsZLLHuaZAlYynUph0YT5mqRSpJ5PAYPlpfryfna0/GdFQ8kcrj8V4JF
	eFAZfB3Eh6iiiRqAM2QNX0d/StB7b5q+tUYr0luUnceJ3n3jU9r4RJ1noYqvjLLWEPFjuVAhjzC
	/8GogbdWo2XH7U0HxhJbDBjL3P12FDmiQ18kqQaQ05QaBIAOms0zVkabof8soRJt4wRoKIMyBYk
	PmGyU6noMPw==
X-Received: by 2002:a05:622a:59c7:b0:4b5:6f4e:e37 with SMTP id d75a77b69052e-4b77d0a6081mr68549631cf.25.1757711592227;
        Fri, 12 Sep 2025 14:13:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMw9fpUjKztDhFj7vngF7IcasgotLQXC7Sz/FG+fDJqIxlNqO5vbKN00AADMBFHKIX07xTcQ==
X-Received: by 2002:a05:622a:59c7:b0:4b5:6f4e:e37 with SMTP id d75a77b69052e-4b77d0a6081mr68549191cf.25.1757711591843;
        Fri, 12 Sep 2025 14:13:11 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b639dab102sm29277371cf.33.2025.09.12.14.13.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 14:13:11 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <6831b9fe-402f-40a6-84e6-b723dd006b90@redhat.com>
Date: Fri, 12 Sep 2025 17:13:09 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rcu: Remove redundant rcu_read_lock/unlock() in spin_lock
 critical sections
To: pengdonglin <dolinux.peng@gmail.com>, tj@kernel.org, tony.luck@intel.com,
 jani.nikula@linux.intel.com, ap420073@gmail.com, jv@jvosburgh.net,
 freude@linux.ibm.com, bcrl@kvack.org, trondmy@kernel.org, kees@kernel.org
Cc: bigeasy@linutronix.de, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, linux-nfs@vger.kernel.org,
 linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, linux-acpi@vger.kernel.org,
 linux-s390@vger.kernel.org, cgroups@vger.kernel.org,
 pengdonglin <pengdonglin@xiaomi.com>, "Paul E . McKenney"
 <paulmck@kernel.org>
References: <20250912065050.460718-1-dolinux.peng@gmail.com>
Content-Language: en-US
In-Reply-To: <20250912065050.460718-1-dolinux.peng@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/12/25 2:50 AM, pengdonglin wrote:
> From: pengdonglin <pengdonglin@xiaomi.com>
>
> When CONFIG_PREEMPT_RT is disabled, spin_lock*() operations implicitly
> disable preemption, which provides RCU read-side protection. When
> CONFIG_PREEMPT_RT is enabled, spin_lock*() implementations internally
> manage RCU read-side critical sections.

I have some doubt about your claim that disabling preemption provides 
RCU read-side protection. It is true for some flavors but probably not 
all. I do know that disabling interrupt will provide RCU read-side 
protection. So for spin_lock_irq*() calls, that is valid. I am not sure 
about spin_lock_bh(), maybe it applies there too. we need some RCU 
people to confirm.

When CONFIG_PREEMPT_RT is enabled, rt_spin_lock/unlock() will call 
rcu_read_lock/_unlock() internally. So eliminating explicit 
rcu_read_lock/unlock() in critical sections should be fine.

Cheers,
Longman

