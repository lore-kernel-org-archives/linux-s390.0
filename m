Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E282363C6F;
	Thu,  6 Aug 2026 16:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786034054; cv=none; b=qjL2nLCPBChDj5G7FnFpNzD4AiczscNn9nU/SrsKxfz19f/pbLoMfjzZHMKdKjPi3Dpwc7Qye345v05E1nxrU5BNicysOvLprzJNDiErWvKknb4th6C9DA+3KEQ3SH+0ME9QIN14ibcHWczKQTa7OmTFXkzB26S51G6HMC7824M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786034054; c=relaxed/simple;
	bh=TAJOsangZEjkB/qJxZuTNSMztDlfw+XlfrFAYaWpbmM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SuA7zwb7HA5zrc0nXlTy7OIRc0aVqWZI9aTBLlYm7JxAizy7N4jUcVO01iSS998i5e+z7GZu2/RMTchgdF9FV3vCX0N/CkF1nDsQT6rZyTPQZaMjJwHFYACktji1EDShhM2umLggOc2e8PgBoWAzoEzr1WuGt27CPhskc2CBD0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=2Mc7G642; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="2Mc7G642"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4hGCXh4xtdzlfwHS;
	Thu,  6 Aug 2026 16:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1786034049; x=1788626050; bh=WMEdtdTMk8wU30+g6elPhGo/
	XKRCXrqMtw4Ci5rUXKg=; b=2Mc7G642ydcd7CUeSZcvOe+DmrjwNhKOsp+VCS8d
	YpZori0n62LJEDMYQPy24+eLHruIYw4ev32cbJ94EZZnDyIYA0XYHdOvrk1kO2Bj
	XJPawMMbsbujzkMMJXJsxzLAnQKoL75Qh/1i/a1KDme48bJZOofK7ltOFMIEqo26
	jKWb6jGCTiDj+rBhp8k4kn/1gXd4fvPeLOxhh6z58Irz1/P6DOEftDm/Ds80m5Fx
	N8hhvbOeSdzOmlVgiM+JDRjHllHKI+2Ja1wHFve5eOl2ABXpKwK/58WvM9fVT7bX
	TiXaF4QfQJsrvnnT26r2wtzcH3Z63rN24/L6silc919Gwg==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id eZKIT27DlorZ; Thu,  6 Aug 2026 16:34:09 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4hGCXc03xSzlfvqS;
	Thu,  6 Aug 2026 16:34:07 +0000 (UTC)
Message-ID: <f6ec3927-cf77-484c-a3d8-c0417f2f2870@acm.org>
Date: Thu, 6 Aug 2026 09:34:06 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] s390/dasd: Add __context_unsafe() attribute to
 various functions
To: Heiko Carstens <hca@linux.ibm.com>, Jens Axboe <axboe@kernel.dk>,
 Stefan Haberland <sth@linux.ibm.com>, =?UTF-8?Q?Jan_H=C3=B6ppner?=
 <hoeppner@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-block@vger.kernel.org
References: <20260806130050.2057443-1-hca@linux.ibm.com>
 <20260806130050.2057443-2-hca@linux.ibm.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260806130050.2057443-2-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/6/26 6:00 AM, Heiko Carstens wrote:
> diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
> index bacf770c0e1f..b4dcef06edaa 100644
> --- a/drivers/s390/block/dasd_eckd.c
> +++ b/drivers/s390/block/dasd_eckd.c
> @@ -1468,6 +1468,7 @@ static void dasd_eckd_path_available_action(struct dasd_device *device,
>   }
>   
>   static void do_pe_handler_work(struct work_struct *work)
> +__context_unsafe(/* Conditional locking */)
>   {
>   	struct pe_handler_work_data *data;
>   	struct dasd_device *device;

__context_unsafe() should be avoided if there is a better solution. For
this driver I propose to make the following changes:
- Change dasd_pe_handler_mutex into a semaphore. This driver locks this
   mutex from one kernel thread and unlocks it from another kernel
   thread. That's not allowed!
- Split the dasd_eckd_read_vol_info(), dasd_eckd_release(), ...
   functions. Move the code between the mutex_lock() and mutex_unlock()
   calls into a new function. Rework both functions such that the
   mutex_lock() and mutex_unlock() calls end up in the same branch of an
   if-statement.

Thanks,

Bart.

