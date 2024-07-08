Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC3345BEF;
	Mon,  8 Jul 2024 22:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720479118; cv=none; b=iEaF1g/9QKmE2EeyQLwU1fsv+/Gzf5e1QrgXxC+2kukTqkwZJvjxRGQhhTYS2jmUQi80GhD3WyepahBE08fdZEFUppNYy+JDR5/RjOcKMT0z7BvmPKrEI/iHN2xC1UryMwCsGoDZdirAV8tMXGLe/ZjHxxWdR8jawelMwo6F/VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720479118; c=relaxed/simple;
	bh=BaeSK8VL0osIikIB9i5thgSjcGWi7CWbmFZlyc7yXoU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qyWNQeRnABKDDVHQEw7l0FozOQJnjjWSzNkYCb638DQHOG14WFg1KdN6zCNLv8YbAn5GZRL6QGs4T0hGDKQ5JckrbWfFmxiwL1diFWciT8Xgn5P4dW8MUZxtQ4a2oj7pBuODSgZnO6eMo/dJHb609jm2tY/yZWMDkYvNFz97I5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CdOCUmI3; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CdOCUmI3"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f65a3abd01so31704935ad.3;
        Mon, 08 Jul 2024 15:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720479116; x=1721083916; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8srVywQNWWPgpGI5XryznETXjclcLlACCGDSu9pPwTw=;
        b=CdOCUmI38OsngyuFdoWdJ20Cz5oP97N17LOW/F55JMpV5o25Yorpw1U8ghFbVrjSmd
         xgWelskmtqHEA+uurRZRf6JeWtqQ0HOIhZrhl5x8sFfJGsMdFkdgsa93uT6J2BMXuu3C
         jmGipmf7AELP9lNnPgzIb92RuEL7+n+n+8aMpHggWcpI7AcoPuQ8aeiAI5jThw4mHzF5
         FhWqRXo0Z1rivqgdUdF+vi+/owTzCP12niflESM0IxGMWqUW6y6OqjOX/uLsx8JD9qhp
         tM3a02AhfRXf60XiCJdOBv4IlZdII2aplT2jCrICMxd9C8MDefvjbn10YFw/Q4B4ulvN
         JVzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720479116; x=1721083916;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8srVywQNWWPgpGI5XryznETXjclcLlACCGDSu9pPwTw=;
        b=BRNP2EXKLjNtKLR6gD6CT1i43SfR3c2JHfeoTSY75alN8axxjPh1kq8C2Tn5RKmiG0
         5iBj/8p3R3NiYmzNXKcgSuBvenQ4nYyNm4wIPVmXe+T4D98g+2A0b+FPIawENEEwzgcv
         +06NvkzSye5071S9o5mzw5/Zqx7oVwlXgwbV9NArHJI+79WMsDLHffPEhpvt7Q2MnRNU
         urx5aBinSUHcEKsJFjlvhd2hIFKNKrLMwBMn5lPAxvMrFDNibQiveuyG3BoBhjGVXnTA
         mfv9PLgbZaSk0lIqDiVKbnt+hs/EHejfaCE5Tv5qafm4CPKvW2n4HmGuYHNfLq/pBiPz
         LmNg==
X-Forwarded-Encrypted: i=1; AJvYcCW8ErNCLE3diQrh6PWOMR36h9QGKKnUkzA/h8OmF3zA+AFnZiL+/nAjS+4LHUeUG6SA3ZWpJU44pyG704+DSzqG4OcYz3ppa2BYjatuaWUTVQi3BAtn0TU1MQL3uXCs26ecl+dtWIQy3w==
X-Gm-Message-State: AOJu0YxeX13Ztn6vQC5n7LvXfZcgWUJVw2f3+FYIyVY+neGjZ280jaO7
	fBdS/z80iyLt/A2yCyfqCviH4SwrDr7zWmQ+unOHco64Prs8Tq3+
X-Google-Smtp-Source: AGHT+IE4gALPYWza3/xf9ND9sKmPMlgPWyMMwEpsRiHkm4yhjH+VkTr6mvBRquiS6avJMGz+Qs4CRw==
X-Received: by 2002:a17:902:c40e:b0:1fb:80cb:f577 with SMTP id d9443c01a7336-1fbb6d23bdamr5769945ad.5.1720479116408;
        Mon, 08 Jul 2024 15:51:56 -0700 (PDT)
Received: from [192.168.50.95] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6a11890sm3823825ad.7.2024.07.08.15.51.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 15:51:56 -0700 (PDT)
Message-ID: <56d2ff54-3c3a-4fb3-8006-72e183faa8bc@gmail.com>
Date: Tue, 9 Jul 2024 07:51:51 +0900
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390/zcrypt: optimize memory allocation in online_show()
To: Dan Carpenter <dan.carpenter@linaro.org>, oe-kbuild@lists.linux.dev,
 Harald Freudenberger <freude@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, shjy180909@gmail.com,
 linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
References: <ebe44c83-19bd-43e9-8999-99e3ccc7b417@suswa.mountain>
Content-Language: en-US
From: Yunseong Kim <yskelg@gmail.com>
In-Reply-To: <ebe44c83-19bd-43e9-8999-99e3ccc7b417@suswa.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Dan,

On 7/9/24 12:55 오전, Dan Carpenter wrote:
> Hi,
> 
> kernel test robot noticed the following build warnings:
> 
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/yskelg-gmail-com/s390-zcrypt-optimize-memory-allocation-in-online_show/20240626-071004
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git features
> patch link:    https://lore.kernel.org/r/20240623120147.35554-3-yskelg%40gmail.com
> patch subject: [PATCH] s390/zcrypt: optimize memory allocation in online_show()
> config: s390-randconfig-r081-20240707 (https://download.01.org/0day-ci/archive/20240707/202407071714.4AUEoeUD-lkp@intel.com/config)
> compiler: s390-linux-gcc (GCC) 13.2.0
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202407071714.4AUEoeUD-lkp@intel.com/
> 
> smatch warnings:
> drivers/s390/crypto/zcrypt_card.c:103 online_store() warn: iterator used outside loop: 'zq'
> 
> vim +/zq +103 drivers/s390/crypto/zcrypt_card.c

Thank you for the review. I decided not to work on my patch anymore
after the review because my patch was problematic and not useful.

> df6f508c68dbc6 Harald Freudenberger 2021-04-13   90  	list_for_each_entry(zq, &zc->zqueues, list)
> 2ff6be56a27c2d Yunseong Kim         2024-06-23   91  		if (!!zq->online != !!online)
> df6f508c68dbc6 Harald Freudenberger 2021-04-13   92  			maxzqs++;
> df6f508c68dbc6 Harald Freudenberger 2021-04-13   93  	if (maxzqs > 0)
> 2ff6be56a27c2d Yunseong Kim         2024-06-23   94  		zq_uelist = kcalloc(maxzqs, sizeof(*zq_uelist), GFP_ATOMIC);
> e28d2af43614eb Ingo Tuchscherer     2016-08-25   95  	list_for_each_entry(zq, &zc->zqueues, list)
> df6f508c68dbc6 Harald Freudenberger 2021-04-13   96  		if (zcrypt_queue_force_online(zq, online))
> df6f508c68dbc6 Harald Freudenberger 2021-04-13   97  			if (zq_uelist) {
> df6f508c68dbc6 Harald Freudenberger 2021-04-13   98  				zcrypt_queue_get(zq);
> df6f508c68dbc6 Harald Freudenberger 2021-04-13   99  				zq_uelist[i++] = zq;
> df6f508c68dbc6 Harald Freudenberger 2021-04-13  100  			}
> e28d2af43614eb Ingo Tuchscherer     2016-08-25  101  	spin_unlock(&zcrypt_list_lock);
> 2ff6be56a27c2d Yunseong Kim         2024-06-23  102  	while (i--) {
> df6f508c68dbc6 Harald Freudenberger 2021-04-13 @103  		ap_send_online_uevent(&zq->queue->ap_dev, online);
>                                                                                        ^^
> zq is an invalid pointer here.  It's an offset off the list head.
> There used to be a "zq = zq_uelist[i];" before this function call but
> the patch deleted it.

My patch doesn't mean much to me at this point, but if it needed to be
fixed, I think it should have been.

> 2ff6be56a27c2d Yunseong Kim         2024-06-23  104  		zcrypt_queue_put(zq_uelist[i]);
> df6f508c68dbc6 Harald Freudenberger 2021-04-13  105  	}
> df6f508c68dbc6 Harald Freudenberger 2021-04-13  106  	kfree(zq_uelist);
> df6f508c68dbc6 Harald Freudenberger 2021-04-13  107  
> e28d2af43614eb Ingo Tuchscherer     2016-08-25  108  	return count;
> e28d2af43614eb Ingo Tuchscherer     2016-08-25  109  }


I've been doing some Linux kernel research on the IBM Cloud s390x VPC
and running syzkaller and Linux kernel tests tools to send out useful
patches. :)


Warm regards,

Yunseong kim
