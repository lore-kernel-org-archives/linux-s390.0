Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793368087;
	b=QghYujejAFpPgaAMYpgdZjUpWMtEoYFOdBkzKIRLlGD4dMAAOFgJaoFkhve9vBEXPdq0
	 G71xooREGqaNajDiPAQaA5zEFT+v4gs9NFQrnMrSXxZsyQYIlOjvP3poMAM/fitCoAGOA
	 InCP+oohROBcp+RQUmYABsGYVpPM/woXKihXjwqzTI6j33PYRA+zYknp0G2/CKN9R84qf
	 Sln/xlLTsvNiBPa61ETLF2+KNmJSUzkGJFUqeK+0D13A2Rw0Fx6wQEeF8q8iPHX8L9QqQ
	 lL2a16tG8vRsswVfvOLG3LerGDNhfQvI7ASIVUmWbMfdYK6Q/YtTVZnRhPSkDYc1egg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793368087;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=rmX4JEwV7qAmy43PkgvX967p02rESGhBBxr09gc4cBg=;
	b=NHbeUFguxgYS3XDIsOeMQN6itn/MQm7debUxMxt+th6PvCD+v+wvLWp4wRmjKctXb3P/
	 HSkxNRfJ/19/h8EK7iK+19JpKAErzl0untQYm4GaCqg6F+WEIf5F4pLrjDoaq/FGr+D4z
	 55T3pT/EQWj40t3i1ygvk4m7hnm2OuohCQF5odhJflUm4jOB+QNh1kqMe92Ma7+4Ls13p
	 tcrqoJGtzrsoMkM5mOc6DYczNZ8XLUfZ66HkjTMOjixVVBx3AWMBV+NN2C85sWC1ypUUL
	 UMqlFnHxxJdvEvE6jtu0G25ueNS0sZS9XzgsD8nJzeCR3XtyoJWZLzULrqiPz9zYS9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P0o7zm7K;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AAE606A324
	for <linux-s390@vger.kernel.org>; Fri, 30 Oct 2026 13:48:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11AAE606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P0o7zm7K
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a35a60499eso6734365e9.0
        for <linux-s390@vger.kernel.org>; Fri, 30 Oct 2026 06:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793368085; x=1793972885; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rmX4JEwV7qAmy43PkgvX967p02rESGhBBxr09gc4cBg=;
        b=P0o7zm7KEPIXltx3NlgMQzHQT99NsbdanhX5hUYiA8mqcXpAtEl9r+/7vE4Ggfb6xQ
         AjDmKEsJCN3A9nhHSHYQq86Tx9QzgKkEoL+MNKiu90Y6d/c6qq8wEeWDbGqZ4zOp73t2
         V+jiEVsBNp3JryoT0gq/L7+LKDEBausQ7tqgfI+sigyrm1PvM7UpDQc9g0naBiUQsKsm
         txn6SCcpysT3ZLStg89zxyyBWbPd9BONg/H56ElBDxvktEsTFh0x/DFDQ8EoFwz5gpkM
         +r9npc2iAjvhv6WuZ+vHLzVgZO3yPFE7oA+XMRoLdTuvTODgouxb21kNS1YSNNzhhvRI
         MLgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793368085; x=1793972885;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rmX4JEwV7qAmy43PkgvX967p02rESGhBBxr09gc4cBg=;
        b=CT18npaGyLYSm941RO1TREK3EKK86cPx6XG80SarKyrqMDYUY7v7SjIjBwZX5BzStt
         oczicN9F9P6w121onJNNs0NgfWtjnCU6KH2uaw+Vr+O05WhgynWXQPwABz080+1hMxRH
         36AfUiL7CuNZsl+lOOhrnnbxvRv9aoKkW2oqOtCgQdZz7UuZRSJBlO/BpuIBesdrHToW
         pe17RxmzTXn9RiUA61W+SV0eyCu050FrEAjCoNv2VbJNdbAIMnqdAmYqXVJI3yozpFBE
         DeR2N6TsUO56obGV0vsF+SIRf/UEvYHA6N0ciMfAe7DZSIArn6UDTR4CzdNDlXx/gTL1
         Q/+A==
X-Forwarded-Encrypted: i=1; AKwUvByW8vMuNe7WBDnIMaZFo3qQ9/AY9Ij4nOFP1b70BOTF0v34GsH6+0H0uCk0IjXPHlMdj/cYAvQ8HqQp@vger.kernel.org
X-Gm-Message-State: AFq9FYJ6Fn8x39C63BHFzMSd6BDahIvysnyfUCp30Y+eIlcNVo9HxBOM
	pUKIQAHdD3ow+DtOAw0drlzH4/AAsPct4FEO2ZJ9h7D/HHSNRRIbZecE
X-Gm-Gg: AYBFou2Uk5zhi0IO+p+1uT61KIomEMsX0r/SPSEXNWNz/iW43tSuyPMOQ+zra3eY2kd
	592i5EdnIlKFO9579c4X6+CuMVZmRdBrko3uzEpAuqWzE4FgY7nIV1s84zdgBXvHxpe4/srQqQp
	itGFccqAPNFJlT4PKIxXQJhlMBd8KJbYiFpxarnPuGtQsIqtVAbgFHLS7wifMx6ngVzwLDXDDtk
	vmb8enxzCrUuGMvhRhYS7kaE9511pondpU4UV/uHBMhslMChqQ0E+bp7VgZwErVE0otjEDbbIOY
	ymwp/X6UYfbC9iLn8wWxpMfAEvlWgE83oews87ZKAMLol0tCgae3YkRTOwWWGvggCo2J6XmWFJY
	UWNEMq7OuY5+VoYd06UNXGgUJ6aWywbIa9Ts8JSL4kuH8KwTH40D82p5jz51Yd9adffrtFDkDrq
	dG2Jdn+wwxnVerdsv90QcWS9h9GGeSMryJfyXGx4PW0giNUH6L3xvvhmFYxG0n6mgW8armKIZcg
	36l2x+sLrvjpfoZne2HBET5D9bgPbn9LqmRiKR6Za7PbKdfIILaPrgTjbcfXZsCHnkxCrSE9Ks4
	y9jlDyViJuvY6AHTBaztL76cjgxFIxJjgaA4MWcfP2fisCyHpF8jQBIalJSUzly3nqkCZ1z2FMt
	tiimbAZHXj8CFQg==
X-Received: by 2002:a05:600c:34d1:b0:4a2:526b:d3fd with SMTP id 5b1f17b1804b1-4ac1793fb5emr50752935e9.15.1793368085145;
        Fri, 30 Oct 2026 06:48:05 -0700 (PDT)
Received: from C422HJQPQG-Fractile ([130.43.154.100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ab69b54742sm172048905e9.15.2026.10.30.06.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 06:48:04 -0700 (PDT)
Date: Fri, 30 Oct 2026 13:48:02 +0000
From: "Vishal Moola (Fractile)" <vishal.moola@gmail.com>
To: Muchun Song <songmuchun@bytedance.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Alistair Popple <apopple@nvidia.com>, Will Deacon <will@kernel.org>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Muchun Song <muchun.song@linux.dev>
Subject: Re: [PATCH 0/2] mm: Remove pagetable_dtor_free()
Message-ID: <auSgElFWW4n3sJLb@C422HJQPQG-Fractile>
References: <20261030083800.599152-1-songmuchun@bytedance.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261030083800.599152-1-songmuchun@bytedance.com>

On Fri, Oct 30, 2026 at 04:37:58PM +0800, Muchun Song wrote:
> This is a follow-up cleanup to the page-table teardown fixes [1].
> 
> pagetable_free() now invokes pagetable_dtor() for constructed page tables.
> This makes pagetable_dtor_free() redundant and leaves explicit destructor
> calls immediately before pagetable_free() duplicating lifecycle handling.
> 
> Remove pagetable_dtor_free() and convert its callers to pagetable_free(),
> then remove the remaining redundant pagetable_dtor() calls. This keeps the
> destructor decision in the common free path. No functional change is
> intended.
> 
> [1] https://lore.kernel.org/r/20261023063428.3658761-1-songmuchun@bytedance.com
> 
> Muchun Song (2):
>   mm: remove pagetable_dtor_free()
>   mm: remove redundant pagetable_dtor() calls

For the series:

Acked-by: Vishal Moola (Fractile) <vishal.moola@gmail.com>
