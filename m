Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B501DDC33
	for <linux-s390@vger.kernel.org>; Fri, 23 Jan 2026 18:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769194526; cv=none; b=mfMaymCRYXPxDPZJbXFOF+UPHs6vx0zMZovL/BrQGZXRuMW3SbCPicId0cWLyr89CPewfhj9iN4sc03aCgCBhByyWwqdl3lvTH9oucD+QBHxUOcoU0/a7XamoKfUURyVCmXulwbIGxurP7Q9Oh8X8o7cn2HuUwoOSDd9mW9uguY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769194526; c=relaxed/simple;
	bh=DC9rNWfCiMVA2t6yQSZiMua5nMrtCbgvS3iX2Q0nBVQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bqOzPpoSjLk5RrHHVCYj/3JHFRlNMyvibUwDMz8PkVdqxR3kvTzWVc0ygxxbWk+EcdYek7GpdTEVhm8AAIMLbg223yMnm3um8KKsbGX4rhcJbWyufbkqy0fCbOGeKJVmj00yTBEpmFeipFWzvftN5XIK1Yp0m+98aUKoLnT92vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hbX3Hzxm; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hbX3Hzxm"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-59ddf02b00aso2619194e87.0
        for <linux-s390@vger.kernel.org>; Fri, 23 Jan 2026 10:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769194521; x=1769799321; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sEFLsQyzoxdu1YcF2YnABjIcE2WnszBPzD975tlZq2A=;
        b=hbX3HzxmSjZs0kxJC1leAATZIT/Xoow9itXABRslTbdvWKXxVbf9FgACKRAUohART5
         c+/KhLstQptagdMm2+dVRSj99UJALMJqu6aElKnKrlIfQKcSnm9n6M+x8xL0NEDZVNBc
         BHvy4cNui71qy62OsGzU0LlW75bXUqIkwb0mg/sok1rGBPGqWitCbFfl8tl8fW37AhLY
         zORwkg21YCxcEUST5orrzEn4/zyXDJcPks80p83e47ceQjlUIJFmH6Q2QBZ+A0hv6WIg
         lXspZkbair7Hlq595gu1EBJ+yN5zIeaN2E3rej8T2yjmsE/jK7lRAc4JRZW5BtMYhOMo
         ZIkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769194521; x=1769799321;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sEFLsQyzoxdu1YcF2YnABjIcE2WnszBPzD975tlZq2A=;
        b=mS6HcGfCBB8LAINSCxE8aqi13x2R/2Uv3duNsSh74DPnVOnrHzSP1/EK5GAq61hSas
         UfSekTcBP7aXvtFjGKwpvVkLx9Dv+aVI8zT9out/r226Qr3Dp4DUSBdVXob79SSp8gwV
         UvYmUgXchaQ9oqj3f0XkBaUockqkuLccJKKWrwa7v7L8jeL7fINLTF5O7jLHdJjDVWZ0
         H0fiHw7soJAglYaeivTrhEAfnKWWWtBSthltIIG1071jN6m0rtir+zgKRjvZ5469R5PC
         7vC99EPBSWcGwytgVIizFkXjm2tAXLdDOlwGXbx/FGG2RwMfXG1Q8YYWyY5g7l8qjDPG
         sfrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWxvphvbBXlFciU8E9odpECax+pIDCQY3uGSB2wNRM56UQhlU0/m9tHcHN4w00pd+SdI5Aj2bbZ13Q@vger.kernel.org
X-Gm-Message-State: AOJu0YyKiRMQgm4Kvefs3VOg8JxdWzKJ02vZDJxMCyWFNDMhDUakSw6D
	+DD7im00NgWhfsGT2SmRrC7yJioRDSng9oDuZsFyHBPXlPBwip5J/jO6
X-Gm-Gg: AZuq6aKyli5yfbVhJJqeoCtyP1iE0BN/DubBkW9m1PzVU/rQeKqoSFyEKg0lyk3Lasa
	RhDzVvmTPDV+ZNPxhPvhORhbbGSHQpQZWp5zAt/3MKcmvMvQ+m4Olj/S9HVWEo/LE2bAON8hupr
	cHN+nf+aCOIjIEDlcJoTJ+qup/HyHd/1LzgcI2ZCPRe2mgK6iwHtxMUTEfWB/9I27fy1QpRX/Qz
	8xkoOPS5Dw9EA72S78SE4SDtyG6aY2fbP/D39BmQawfM3i7HZYZLKu8xyZeJLld7gwfm1ddpPCr
	lERXz7FHkACysS95R+3LJ9fpGQE09EOuDHUdcNLNoO8DOB9mv2KHIlPrIw2/PaC3Erw19p78k30
	nJUeNjxLYKO/XuVff+RL7RLD9F9kQSa+jOKqirSsJy0/KxlRoM9Rz
X-Received: by 2002:a05:6512:2254:b0:59d:e7b0:cfc with SMTP id 2adb3069b0e04-59de7d7309dmr849185e87.15.1769194521113;
        Fri, 23 Jan 2026 10:55:21 -0800 (PST)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59de48e6023sm848831e87.32.2026.01.23.10.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 10:55:19 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Fri, 23 Jan 2026 19:55:17 +0100
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dust Li <dust.li@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Simon Horman <horms@kernel.org>, Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org,
	oliver.yang@linux.alibaba.com
Subject: Re: [PATCH net-next 2/3] mm: vmalloc: export find_vm_area()
Message-ID: <aXPEFdEdtSmd6AzF@milan>
References: <20260123082349.42663-1-alibuda@linux.alibaba.com>
 <20260123082349.42663-3-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123082349.42663-3-alibuda@linux.alibaba.com>

On Fri, Jan 23, 2026 at 04:23:48PM +0800, D. Wythe wrote:
> find_vm_area() provides a way to find the vm_struct associated with a
> virtual address. Export this symbol to modules so that modularized
> subsystems can perform lookups on vmalloc addresses.
> 
> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
> ---
>  mm/vmalloc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index ecbac900c35f..3eb9fe761c34 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3292,6 +3292,7 @@ struct vm_struct *find_vm_area(const void *addr)
>  
>  	return va->vm;
>  }
> +EXPORT_SYMBOL_GPL(find_vm_area);
>  
This is internal. We can not just export it.

--
Uladzislau Rezki
