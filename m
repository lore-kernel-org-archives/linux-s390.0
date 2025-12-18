Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B43339717
	for <linux-s390@vger.kernel.org>; Thu, 18 Dec 2025 10:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766053035; cv=none; b=oexC/yOKNr8Rw57Uyrd1BPIGb1vtRZuoTrWwMKPyQqvv8x5S8j6z1Q9URy/RoQHu/ygEw4qn0t+h9d74HC7zeW1X7mbXsToCSpqOB8ZztmTz1I1l5572eAccRQiEB92qOD2ajs8J8XdtxLzLAg01ZkGoSJXk1QcVfEKWM/AWmvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766053035; c=relaxed/simple;
	bh=qUDlOrGbvl8kArMeRYEQd3FV6BD9bHHxHFRz8SSOy5o=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=INplDAM8BycaWBuy2Ltkki/ZX1H/daZJEOFBhs73qNdMXOQ8oSmVv5FQGQki1FB+UkwcEEY4hJ9h86fjLE9Ig9WfosqPA2uzQw8+dZS4XNAzNM+sPpQ/fbr7gnwOKeEkOdHKueGvEOJyfb5/agg4kOAqw5SAnFu4Fs+fHbhs0HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fQYttwol; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fQYttwol"
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766053027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=asGEHGyQRJb6ndRrOdpeGDscGg6dMkDnZI1jx4ruYjw=;
	b=fQYttwol0fxcAFcmJftk8+KFXyOTaK8gdGiF0wcfY29Q3Otz+YVjRnbQnUyIZ/LIPkxtgW
	P8Qj53RS8840gipVw9CCJyOxFq7W0nCutk1zBbZCRjQ/ZS1B8FNgdPzmOlMyQPEI0qp8vd
	Ptw19aDZWro6xQ0fOfXnDdGVmnKbfHo=
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH] s390/spinlock: Replace simple_strtoul with kstrtouint in
 spin_retry_setup
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <35571508-723e-482c-a729-6ffccaae14e7-agordeev@linux.ibm.com>
Date: Thu, 18 Dec 2025 11:17:02 +0100
Cc: Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 joel granados <joel.granados@kernel.org>,
 Juergen Christ <jchrist@linux.ibm.com>,
 linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <2022390E-B83C-4087-99D0-596A198E337B@linux.dev>
References: <20251213123246.356155-2-thorsten.blum@linux.dev>
 <35571508-723e-482c-a729-6ffccaae14e7-agordeev@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
X-Migadu-Flow: FLOW_OUT

On 18. Dec 2025, at 08:59, Alexander Gordeev wrote:
> On Sat, Dec 13, 2025 at 01:32:44PM +0100, Thorsten Blum wrote:
>> Replace simple_strtoul() with the recommended kstrtouint() for parsing
>> the 'spin_retry=' boot parameter. Unlike simple_strtoul(), which returns
>> an unsigned long, kstrtouint() converts the string directly to an
>> unsigned integer.
>> 
>> Check the return value of kstrtouint() and reject invalid values. This
>> adds error handling while preserving existing behavior for valid values,
>> and removes use of the deprecated simple_strtoul() helper.
>> 
>> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
>> ---
>> arch/s390/lib/spinlock.c | 3 +--
>> 1 file changed, 1 insertion(+), 2 deletions(-)
>> 
>> diff --git a/arch/s390/lib/spinlock.c b/arch/s390/lib/spinlock.c
>> index 10db1e56a811..b4ca53356b96 100644
>> --- a/arch/s390/lib/spinlock.c
>> +++ b/arch/s390/lib/spinlock.c
>> @@ -34,8 +34,7 @@ early_initcall(spin_retry_init);
>>  */
>> static int __init spin_retry_setup(char *str)
>> {
>> -	spin_retry = simple_strtoul(str, &str, 0);
>> -	return 1;
>> +	return kstrtouint(str, 0, &spin_retry) == 0;
> 
> Why not to use kstrtouint() return value, like other parameters do?

Returning kstrtouint() directly would be wrong because kstrtouint()
returns 0 on success, but spin_retry_setup() is expected to return 1 on
success and 0 if the parameter couldn't be handled.

Thanks,
Thorsten

