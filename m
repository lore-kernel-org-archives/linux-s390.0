Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA684418D7
	for <linux-s390@vger.kernel.org>; Thu, 30 Jul 2026 16:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785428106; cv=none; b=iUm9C0Bp7gXlDF50E+8TNgWgvIXvIN4vBYbFf7ZtsXuCl9DDdnGciwDoSHq7KpRK4ApPjQCWGVZH3QbY3NY5OYe8GQ+GhMFXHtmwqBdfBlllm2Ul/kbfl03gYcwr6iDBSAeu53dkdW3mgqpgYdjPT2hbblgUJH8upLs974I174U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785428106; c=relaxed/simple;
	bh=Prrq3lRrNtjBMcFNoLT6vy0bmYe4ExXeIRC0llIkt7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V62tkykvD+KCRSxoa7EMI9KZbCO9NFRY1o5porjeMgAN0NFqL7hQuu/1YnNyoB9mohYu/e4a4o+j21dzI8T5mfW9lcWCnZutYSo0VSJqePOl0aKmevdJtGfS9J3W4SV+ov9JjiZBGlifnG3jJlek/qvu+NGCxNTh54fIuPqMREw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=aD1x7KZO; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="aD1x7KZO"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3811f512167so35796a91.3
        for <linux-s390@vger.kernel.org>; Thu, 30 Jul 2026 09:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1785428104; x=1786032904; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sc7/PIL5nmBZuTJI/qyxnyFN7S+kHFcyfHQ2vtF45hE=;
        b=aD1x7KZOof0CcjkO3K2mWdjMAAFm27fqdl7lL9hKPfT7nYI/samOcztz60bwQqvTPE
         wFyQsC7b70zbV5K6ObSxMVMDfwqRXrBLb+8MozDJ/MVkPH7qUbhzdEAUYxKLYSGqxLMA
         5coRJy5pRS4vLsXDunzwN4PDIYvKWsQaMEE4QtGTOtlUDa9ijQJETS4xUHaQJh42o1+1
         q31yDnWZcszUH53+AQZNb9dPr94O6Qmme1jJDcEh4rAaH8Sn3X/Peq6mLw+6bFRTYFCN
         aE5yGr82pAMRs/cmeZkd42a4dpwg2XgrW0bhcBbOM8re1S7ktPRrEAFLhrYcnD/FtP/f
         WbkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785428104; x=1786032904;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=sc7/PIL5nmBZuTJI/qyxnyFN7S+kHFcyfHQ2vtF45hE=;
        b=rJmaGc0lSifVz2nwgHeQwsXpaSQQBYzmb7xsL5wE4UXVHstUkZXek6dgBtlCHhaqF7
         Lhu/y0VWyJ5w5zPlLzySHcNCe2F/XCsGiaQkM8j6FuQW+vOLan7srVLJ7IMlmOh1IC4W
         eMqsRMR/OEi7x7ceUFVPUCQzC60Ao3gY5B1KAiSudOin/Per0uW/pp5tKseyetPiI/na
         xpdKZg9N7ObTKQWVhNeOABxgCS1TZ2s0OPKeZSlIqwAUp1KwhmLsNZr8pTJgqJnQPyzy
         kzpIaeFb4tSrzsS+WO0eSXWr1fuY5JulBAu8S4T7913QUxdiKqivbn9xmnOOvivgctH2
         fDzg==
X-Forwarded-Encrypted: i=1; AHgh+RpcJUCawOyq1ztDrTY6EW8ZlcQbdzQzo7hzBzBVWnb5IXYL0y6YrwJfRAUy/BcGNYCWdR9JHo3hehid@vger.kernel.org
X-Gm-Message-State: AOJu0YwYauvUSe9lTCUf3YJX3gEU7x83U31otqMxaJkjmcMihbUviXrL
	WkTGbdjfuTmOd9gUb3oq3IOvJ0wq1g2JNtm70LEIS9jRq1hNYtZGKXwrAgmEHUeKKBo=
X-Gm-Gg: AR+sD10T7zY56Jxc41emlo9Uct4/V7eoH1ZpaNKrlVUa1pz2DEfvWG9Rv8tAsaWL46E
	JKDvdeM5HfpTaKlHvUyrBZ+JISXVNdr8QmekfJVdJ9aQlw19EGEYcqeLDDRRo2SUO7qz3ChIGc2
	i5aVw+KHvJ7yNqcmV00iAxYS0YIOEkS2Lc0QTDMJNlxuIfB9xtKW4zs3GDK+WuNsTMBOg+JtatJ
	T7UhfO0eXTUw5W8Ve1RzZloBYzw21IeX7V2NQc7+sFFhpUrFyrw+73H8zG4fd2//1SejyjppHgt
	PGNB1ir9GlTNy7+bhvAFGQq8ZR6G/tSZ2P+D32lTnB5usDgi0SjglQo6fpLcf5WLrC7lHtGJgkJ
	cpgy2700WhivlJN2A7iHmUt4OLVsvU0XrzSS4mGal7o1MR9d3tsmmg0xUGSRrEzslK6IuTEykjV
	xSVyTSN1boq8PqrWCeRsmTwvLdg/yQIBUrBur8tdPwYfvvUCAAl3O1
X-Received: by 2002:a17:90b:582c:b0:38e:57a3:f218 with SMTP id 98e67ed59e1d1-38f9bdd2f2dmr2888847a91.13.1785428103654;
        Thu, 30 Jul 2026 09:15:03 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:48::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38faba8491esm4092a91.2.2026.07.30.09.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 09:15:02 -0700 (PDT)
Date: Thu, 30 Jul 2026 09:15:02 -0700
From: Joe Damato <joe@dama.to>
To: Hidayath Khan <hidayath@linux.ibm.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, wintera@linux.ibm.com,
	aswin@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
	agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
	svens@linux.ibm.com, horms@kernel.org, netdev@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] s390/qeth: validate user buffer length in SNMP and
 ARP query ioctls
Message-ID: <amt4hhb/IZwi+0PE@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Hidayath Khan <hidayath@linux.ibm.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	andrew+netdev@lunn.ch, wintera@linux.ibm.com, aswin@linux.ibm.com,
	hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com, svens@linux.ibm.com, horms@kernel.org,
	netdev@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260730142216.218309-1-hidayath@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730142216.218309-1-hidayath@linux.ibm.com>

On Thu, Jul 30, 2026 at 04:22:16PM +0200, Hidayath Khan wrote:
> qeth_snmp_command() and qeth_l3_arp_query() allocate a buffer sized by
> a user-supplied length (udata_len) without checking a lower bound, then
> set udata_offset to a fixed non-zero value and pass both to a reply
> callback. The callback bounds-checks the copy with
> 
>         if ((udata_len - udata_offset) < len)
> 
> Both fields are u32, so a udata_len smaller than udata_offset makes the
> subtraction wrap and the check pass, and the following memcpy() writes
> past the allocation. A udata_len of 0 also yields ZERO_SIZE_PTR from
> kzalloc(), which the existing NULL check does not catch.
> 
> Reject buffers smaller than udata_offset before allocating, so the
> callback subtraction can no longer underflow.
> 
> Fixes: 4a71df50047f ("qeth: new qeth device driver")
> Cc: stable@vger.kernel.org
> Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
> Signed-off-by: Hidayath Khan <hidayath@linux.ibm.com>
> ---
>  drivers/s390/net/qeth_core_main.c | 3 +++
>  drivers/s390/net/qeth_l3_main.c   | 5 +++++
>  2 files changed, 8 insertions(+)

Reviewed-by: Joe Damato <joe@dama.to>
