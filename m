Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794323278;
	b=Ex3fBqECtz9uOPfvO4M7Wi5d5GBMTgP5Bw2ovam1cRKaB/Ofljf0MZsxHEiol+dzxvuA
	 EhgAITjoQ+hWCFapKNSliyj70i5LLtQVhAEzOy5ifoZwguz6/gtDPr1ZMqhcsH/CbkufZ
	 B8U4A4ziYkkyEydsRD/bUZbNXcFRuZ8YBRd2xS0YALiVmNE5nJz8veGa5SRexSemrXJNr
	 yeG6j1TbQblkk/LWcGJuOnhByz4jp9mjEuoTNKlYTiQkRwo4UPfzl9Lqw/MbGvOAVvMia
	 b9yjjP7UcxY7I6mXhC7PMiFdlhiE5Gx4Xgl0//7LAR8OOichzOj8hUQ5Fmpbr1vuw/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794323278;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=JtM9UtzYhAWCxTCfoBKbcmHIR3U4Wq7tzdw7gboBY64=;
	b=s/PnfCyqNC+r2PhFJdb4FLwWh5od5Hm+1wKDhkqToq6skeMEq5KvUW3V/BsSX08AqDHn
	 FJVTpJwLV5cuxuaObtnc2uZJt6gg+E04nMl5mK2tBXKtL2NBJiznvmGMACO2z0xXQ1TBU
	 XI41WJQepayOOP4TToclI6t/fXrstPEUqjJVgepCbKv1ivapi9AzI7+JLM009FWuhVZIG
	 CPjmQgs7jzBuV18CVNm5N+GNgna+zuB/zxsRb8SS330FXgU+tqhl2HdmvvbdpFwCgxyhk
	 TgHxb0y9m9CzeyHT6OmJEYsxO2uGyFgtXjtSjq2gvojnqMsXIItioa2ZXvAYlVvIbVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LHozpx7Z;
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375A160A262E
	for <linux-s390@vger.kernel.org>; Tue, 10 Nov 2026 15:07:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 375A160A262E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LHozpx7Z
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2e977109392so12284665ad.0
        for <linux-s390@vger.kernel.org>; Tue, 10 Nov 2026 07:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794323277; x=1794928077; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JtM9UtzYhAWCxTCfoBKbcmHIR3U4Wq7tzdw7gboBY64=;
        b=LHozpx7ZkQyIUBsAkv4C311vzxfheFN2pzrL9Y/FTHkEXQzaVUkMAz9U9wFUejAOr8
         YATASi40x9WcOvyF4dkS6SJQ2bBJHO0yE68WsOT8oewufPXMhMYT6O7d4/5H33a+EMHR
         jjCu1KqktdAA/9c8ZIpbjFjA/3BLyNbgEZc3fS3F9+PTZ5y3jCgkJQ9rhGft5ONP+cJO
         aTEF5vn9sQP8UWqDXO8UszNcV0yZFTKvtrsUk25y1Sz/3h5njQt9uj1PBQLO+FuWPgpB
         LsGoLTWDE/iFYFuKD+GJLya2PXFipxPXM8zYDthkWkjgd0549O004Xgoom3qc/ylK84T
         vykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794323277; x=1794928077;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JtM9UtzYhAWCxTCfoBKbcmHIR3U4Wq7tzdw7gboBY64=;
        b=2aTBhhKrrUlF5SADGcMzlPgG9teQh3ZOqdJYP2MzvnKIgBTJwaQKgCM7xgdcTXPmrV
         ZYMt3C++q/9LNP8svD1cXDb9eSxCDyEKA/wylYc4GQ2HDznxpY2aUtQrispD4nV3zDyi
         plqJRweLmqoyNDP4Uu9W/gTr4lbyBd8yq/lSkkgyavDQWSu2/qvGkfo77MZ16Hgavs7v
         sWwy2z+lU0tT81kQM4XgTSAFQJM7G3qpklVk4O+Ofv045vAN0O0t15jsCdAz5c60E0lT
         tUhZ6RPFOhenPTG6H50RfTtuFzaWxTGhrWqoT/FnGo5Uml+5Coz7OCc/MVl8a/KOr6Zg
         sFnA==
X-Forwarded-Encrypted: i=1; AL+hErFGDnizxIi65rxT9fhQGAPiVrj7FahSn+YK3kGved4N+Epu73j4m4A1Y8dCYGbn/TQ1jLW5IJSadoht@vger.kernel.org
X-Gm-Message-State: APuU4Z8gqfVF+31GzbXInPH6c+ApET7grjSIW4wV9zDVGLTm5wsyKJUU
	crNC8OtaA5PyxW/tdUayFvGwSN8VIt5lTPCwaCFsIISbBj1YpY4FfIvJ
X-Gm-Gg: AYBFou1R4vtFKuZ2aQ/4aLETEcgVKRcU0uNLyEwmOoESu/GqFlkMTx4r5y15v+mbezG
	UsPn6bIoOEWz+2Z9+Y8wNUQP05OvZ5j8QNfREScs83GZlBSliUAzmYEEbuQaSBV9lK+eRFFKNtg
	bxtQT9Cehwo7ZMU+pGvCwaJ3r2UCCK5gHoocHVh8tKmbVSaux9ab+1c+4dZHmJrnIv7vi82jlWJ
	6bcUk/pr/Rcc+Pn4rfpdJzfCl5uIRxMgSAcRbvC3K+3cUhEHMlHqn2LMsGrCx6vRaeD9ZycBDew
	7CjIElJog891tCKpdtq8BvEkT4wEyrSoNY6lPcQtXDbMGZWJZwEQegk7cX1PNnAna/FnMavfm2i
	HkA3hPwdHx+HfTR9JtXNag9iV1p7mpin+FLc615QYgcU/zaaHwy7tyxojGNu4+2+Py8nuUCBDnW
	zY71gjnbKxCiPwaZVWrmuROLcrzS+pv+/npjUbbn4CLkH1i2Oyyr9gKsxrqn6koFahbY+i/xTsp
	pi7DNZJboZ4mk44FWOyWPD1avwBXdOWhZHZV8Zw/24OzJLgMUYioT0RG6q9LQdbMnUL68vq2c2n
	byJT1UOe5MWP8kIpmitGbmaXawQ7wldsjiK8+AxOis4f8z2z/JOiaebPEQSI038QKfeRv5IYaou
	8iMcIXNN/MC0=
X-Received: by 2002:a17:902:d481:b0:2ed:1ef3:9ec with SMTP id d9443c01a7336-2edb9172a2dmr26826345ad.14.1794323276968;
        Tue, 10 Nov 2026 07:07:56 -0800 (PST)
Received: from [192.168.2.6] ([27.75.101.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2edb6d78dbcsm10397575ad.27.2026.11.10.07.07.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 07:07:56 -0800 (PST)
Message-ID: <71f76e5e-ce24-4a71-863a-169ad262c510@gmail.com>
Date: Tue, 10 Nov 2026 22:07:46 +0700
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 36/41] nvmet: refuse files on pseudo filesystems as
 namespace backing files
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Chris Mason <mason@kernel.org>,
 Josef Bacik <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jan Kara <jack@suse.cz>, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, driver-core@lists.linux.dev,
 linux-mm@kvack.org, bpf@vger.kernel.org,
 linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
 apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org,
 netdev@vger.kernel.org, fuse-devel@lists.linux.dev,
 linux-efi@vger.kernel.org, xen-devel@lists.xenproject.org,
 ocfs2-devel@lists.linux.dev, linux-s390@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-usb@vger.kernel.org,
 Amir Goldstein <amir73il@gmail.com>, linux-erofs@lists.ozlabs.org,
 linux-kselftest@vger.kernel.org
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
 <20261110-work-loop-pseudo-v1-36-4c998976c6c7@kernel.org>
Content-Language: en-US
From: Bui Nguyen Nhu Quynh <kaylovefoss@gmail.com>
In-Reply-To: <20261110-work-loop-pseudo-v1-36-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/10/2026 4:14 PM, Christian Brauner wrote:
> The file backend takes any path that isn't a block device. With
> buffered_io=1 that includes files on procfs or sysfs which then get read
> and written by a kernel worker on behalf of the host. Refuse files on
> pseudo filesystems just like loop does.
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  drivers/nvme/target/io-cmd-file.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
> index dfa8aa46188c..71c69bac5394 100644
> --- a/drivers/nvme/target/io-cmd-file.c
> +++ b/drivers/nvme/target/io-cmd-file.c
> @@ -52,6 +52,11 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)
>  		goto err;
>  	}
>  
> +	if (file_is_pseudo(ns->file)) {
> +		ret = -EINVAL;
> +		goto err;
> +	}
> +
>  	nvmet_file_ns_revalidate(ns);
>  
>  	/*
> 

I noticed patch 41/41 doesn't include a test for nvmet. Would it make
sense to add one with buffered_io=1? The test would need a pseudo file
that can be opened with O_RDWR and supports both read_iter and
write_iter. Otherwise, it could pass without ever reaching the new
file_is_pseudo() check.

Thanks.
