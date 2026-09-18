Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949D251DB01;
	Fri, 18 Sep 2026 20:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789762230; cv=none; b=c2bXSvEga9QPyjCtuL9JBmpciATNIf1JTN3lrnDoXhID2NTYN3uDRrRq18SBXvhPSijq0iX144AJwVTQfMcgPkSexcqSGl/5dVAJUxz041TwQN9aBnUYd7PpX8EPGBrpNEbI3VWvxWH5MaBYXuUKflBq9BzcWpfmw1p75tymxtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789762230; c=relaxed/simple;
	bh=nhBdWVV0BRxU1hQrgGak2Y38/8rlU5vydn81yPYx328=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z2IfN92Hr4C09kg/AQOEojy0h/Fm3OmfC9rw1K0x8tm4mxhcHZ4G7vK0z+ob5g+7SV1Bv/v0tfB64DFEiYBCWJi8QnjjkOsFS6oszJUjTx6sCzomreOcfYOAxkL2dlUnY1d2uBu8XQcnB/YUV/m1h/vVN9MH6TGCjhYfngvM6Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=HmW39Iir; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="HmW39Iir"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
	MIME-Version:Date:Message-ID:From:Reply-To;
	bh=/L7wMknOS2DR/OxphxVCxpmpvYnfo0hQIoILtTL7Lf4=; b=HmW39Iir7+/vVQHv9dyNqoi38W
	WYZuZonbqD4r9T8Nh0WBS8p+ApdeZDd8ot3Mirn9qh+UBAT/7IXTyhRepWyQ1gCWOwUkaVH0vl2os
	2o78U7JCRBL9qBOPO5f2j7D4tD7tW/N5nNwe5loX+DAM6Ji946L1IYcqxlUE/4xibeJxhtrY+bXN8
	g3fnfaX4drfI1zXkiTnh9ZvMFgof2R/KMy+ZNunupVWs1T4SPZlNd1h3X6PuMirNITgMAhsrP3vVj
	RKbBhQU6ccsAx/jZjAsfH5aYxZCpbOieuw0jTD1bLG5I4kh9aeBzaup36xWi6VXzj4TXdqM9TlBSy
	VA3eTcHg==;
Received: from [177.172.123.214] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1x7euZ-0046tt-QT; Fri, 18 Sep 2026 22:10:19 +0200
Message-ID: <28a9bbf2-da18-4982-a89f-f8e8d1e2da36@igalia.com>
Date: Fri, 18 Sep 2026 17:10:19 -0300
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 04/13] arm: Use the common syscall table
To: Arnd Bergmann <arnd@arndb.de>
Cc: Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, kernel-dev@igalia.com,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 linux-alpha@vger.kernel.org, linux-s390@vger.kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>,
 linux-arm-kernel@lists.infradead.org, soc@lists.linux.dev,
 linux-mips@vger.kernel.org, sparclinux@vger.kernel.org
References: <20260917-tonyk-syscall_table-v7-0-f4cd8f8e3265@igalia.com>
 <20260917-tonyk-syscall_table-v7-4-f4cd8f8e3265@igalia.com>
 <4fa47186-08b3-4b2a-bbcc-16b14a50ee21@app.fastmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <4fa47186-08b3-4b2a-bbcc-16b14a50ee21@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Em 18/09/2026 03:22, Arnd Bergmann escreveu:
> On Fri, Sep 18, 2026, at 01:46, André Almeida wrote:
>> Remove some of the duplicated code by using the common syscall number
>> table.
>>
>> Signed-off-by: André Almeida <andrealmeid@igalia.com>
>> ---
>> Changes from v6:
>> - Added back syscalls from 403 to 423 to local table. arm32 can't use the
>> common table for those syscalls, because arm doesn't implements compat_
>> entry points for syscalls like pselect6, ppoll, etc., and OABI uses compat_
>> entry points when it's available, so this would cause a build error.
> 
> That's too bad, especially if this is only needed for OABI, which
> nobody should be using any more. I had hoped we could kill off OABI
> soonish, but that is currently blocked on the discussion about keeping
> RiscPC alive.
> 
>
Right. If you don't mind, I will drop arm32 from this patch series for 
now, while we check what will fit better here.
