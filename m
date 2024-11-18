Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532E81863F;
	Mon, 18 Nov 2024 15:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731943434; cv=none; b=oJ2xRYOBbpFfChaav83von0S2Yjz1KGZfz7wB6dq9qL9p8nnhKPeX34AAcLy/l52YIO6LlJiqEI6nk3JGViYOp0cBDYZOy0IeYk0PDQrQxgE8bbpoATl4g/Rmh3W9l56yyRCP1jDVbhq9IzI6IYY75i/BtjhtFOXlAZCgqaTN+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731943434; c=relaxed/simple;
	bh=XapbP4NA/ogzr6iOfold3khQ2Wm5vRa9ky9cJ/ZfHA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oZWhpnF5f60wa0v0DBE9O6NSdP7VaGp6FhBiiDRAjApB7oO37G+oQb3soy6apDuIo16sv7UzFS0OaDZ2v6n6LBJjxVKt3uEa3QeQaUxp/UQ47ZLpwr/UEl6Y5QUKcAyW2LjWAc49wYbD62vEAfcZ+55Hs55rrAI0PCwxav9y0bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 83A95165C;
	Mon, 18 Nov 2024 07:24:22 -0800 (PST)
Received: from [10.57.89.219] (unknown [10.57.89.219])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4ED6E3F5A1;
	Mon, 18 Nov 2024 07:23:49 -0800 (PST)
Message-ID: <9e04fa8f-7c08-49a9-9647-f8d1f183ffcf@arm.com>
Date: Mon, 18 Nov 2024 15:23:47 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] perf: arm-ni: Remove spurious NULL in attribute_group
 definition
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Peter Zijlstra <peterz@infradead.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org
References: <20241118-sysfs-const-attribute_group-fixes-v1-0-48e0b0ad8cba@weissschuh.net>
 <20241118-sysfs-const-attribute_group-fixes-v1-1-48e0b0ad8cba@weissschuh.net>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20241118-sysfs-const-attribute_group-fixes-v1-1-48e0b0ad8cba@weissschuh.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-11-18 3:02 pm, Thomas Weißschuh wrote:
> This NULL value is most-likely a copy-paste error from an array
> definition. So far the NULL didn't have any effect.
> As there will be a union in struct attribute_group at this location,
> it will trigger a compiler warning.

Acked-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
>   drivers/perf/arm-ni.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/perf/arm-ni.c b/drivers/perf/arm-ni.c
> index 90fcfe693439ef3e18e23c6351433ac3c5ea78b5..fd7a5e60e96302fada29cd44e7bf9c582e93e4ce 100644
> --- a/drivers/perf/arm-ni.c
> +++ b/drivers/perf/arm-ni.c
> @@ -247,7 +247,6 @@ static struct attribute *arm_ni_other_attrs[] = {
>   
>   static const struct attribute_group arm_ni_other_attr_group = {
>   	.attrs = arm_ni_other_attrs,
> -	NULL
>   };
>   
>   static const struct attribute_group *arm_ni_attr_groups[] = {
> 

