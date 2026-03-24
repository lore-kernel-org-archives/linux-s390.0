Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291DE849C;
	Tue, 24 Mar 2026 02:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774321197; cv=none; b=gHIiOrj9XXZ66u9H/Kn8aKMtgUzofdns2Wd8IBIWVD+sUnpW9cwknb5ANcP+7gerFrAuJ0UDROEn8jDz0W4XQmKBEHgI86rFot3uAYSNV7FRORCvKvc0Yk1iKLWaL9LKSHZBxUoFid3hbWmO95IaMhTzWK9hKtar8bXMn9F3DAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774321197; c=relaxed/simple;
	bh=E5Oy3ZYpo3+Ps5TNqA1cUlIdTyftlK0p+7R4zW8Vt7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bWzVPS3hwdjez17YxKrR5OYNpF9SAkvQiOzk3qyy22boafAqBboghYT//WERcdyQ15l999SCf5McikeTM/VNGstzZNnqY0CFGvldoLUmTTo0dUWDtA4N/8jKEq/JWkXoYUkPw4Ym4b6lwjeJnr9Bngf2Ldq3SO7CAb3up67jsHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=vj3Xv7BZ; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="vj3Xv7BZ"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774321192; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=B5wXALRpLgA30wVgjjEUsYNnGSqmUm7zNIHZ9rwo58Y=;
	b=vj3Xv7BZJuogcydkfiH4V/ouBdiWwVK9dFVzdCzozhjIeCUox3zQeIaDqRruxbNxMUYXP4dB3khtY7ciOeF8i8ggS0iqVt50GodvDixLJcUscbwx4YXOP8mvnjBeMqDsdEEMeeHPziM04PVgVvWf1HIfQ6ukZ7p7ZWXNxTYPVVU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=35;SR=0;TI=SMTPD_---0X.d.Lzd_1774321188;
Received: from 30.221.131.145(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0X.d.Lzd_1774321188 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 24 Mar 2026 10:59:50 +0800
Message-ID: <9855724f-4543-48b5-bf60-780b5215c103@linux.alibaba.com>
Date: Tue, 24 Mar 2026 10:59:47 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ptp: split clock drivers into two subdirectories
To: Jakub Kicinski <kuba@kernel.org>
Cc: tglx@kernel.org, tglx@linutronix.de, richardcochran@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 jstultz@google.com, anna-maria@linutronix.de, frederic@kernel.org,
 daniel.lezcano@kernel.org, sboyd@kernel.org, vladimir.oltean@nxp.com,
 wei.fang@nxp.com, xiaoning.wang@nxp.com, jonathan.lemon@gmail.com,
 vadim.fedorenko@linux.dev, yangbo.lu@nxp.com, svens@linux.ibm.com,
 dwmw2@infradead.org, nick.shi@broadcom.com, ajay.kaher@broadcom.com,
 alexey.makhalov@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 linux-fpga@vger.kernel.org, imx@lists.linux.dev, linux-s390@vger.kernel.org,
 dust.li@linux.alibaba.com, xuanzhuo@linux.alibaba.com, mani@kernel.org,
 imran.shaik@oss.qualcomm.com, taniya.das@oss.qualcomm.com
References: <20260318073330.115808-1-guwen@linux.alibaba.com>
 <20260318073330.115808-2-guwen@linux.alibaba.com>
 <20260323191645.46569808@kernel.org>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <20260323191645.46569808@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/3/24 10:16, Jakub Kicinski wrote:
> On Wed, 18 Mar 2026 15:33:29 +0800 Wen Gu wrote:
>>   drivers/ptp/emulated/Kconfig                 |  61 +++++
>>   drivers/ptp/emulated/Makefile                |  11 +
>>   drivers/ptp/{ => emulated}/ptp_kvm_arm.c     |   0
>>   drivers/ptp/{ => emulated}/ptp_kvm_common.c  |   0
>>   drivers/ptp/{ => emulated}/ptp_kvm_x86.c     |   0
>>   drivers/ptp/{ => emulated}/ptp_s390.c        |   0
>>   drivers/ptp/{ => emulated}/ptp_vmclock.c     |   0
>>   drivers/ptp/{ => emulated}/ptp_vmw.c         |   0
>>   drivers/ptp/ieee1588/Kconfig                 | 179 +++++++++++++
>>   drivers/ptp/ieee1588/Makefile                |  16 ++
>>   drivers/ptp/{ => ieee1588}/ptp_clockmatrix.c |   0
>>   drivers/ptp/{ => ieee1588}/ptp_clockmatrix.h |   0
>>   drivers/ptp/{ => ieee1588}/ptp_dfl_tod.c     |   0
>>   drivers/ptp/{ => ieee1588}/ptp_dte.c         |   0
>>   drivers/ptp/{ => ieee1588}/ptp_fc3.c         |   0
>>   drivers/ptp/{ => ieee1588}/ptp_fc3.h         |   0
>>   drivers/ptp/{ => ieee1588}/ptp_idt82p33.c    |   0
>>   drivers/ptp/{ => ieee1588}/ptp_idt82p33.h    |   0
>>   drivers/ptp/{ => ieee1588}/ptp_ines.c        |   0
>>   drivers/ptp/{ => ieee1588}/ptp_mock.c        |   0
>>   drivers/ptp/{ => ieee1588}/ptp_netc.c        |   0
>>   drivers/ptp/{ => ieee1588}/ptp_ocp.c         |   0
>>   drivers/ptp/{ => ieee1588}/ptp_pch.c         |   0
>>   drivers/ptp/{ => ieee1588}/ptp_qoriq.c       |   0
>>   26 files changed, 296 insertions(+), 253 deletions(-)
> 
> emulated sounds good but the ieee1588 doesn't sit well with me.
> IEEE1588 doesn't describe tickers and external signals.
> Let's leave them in the main directory? Or call it hw even if
> it's not 100% accurate? In MAINTAINERS you can exclude subdir
> with X:

Thanks for the suggestion. Leaving the network-oriented drivers
in the main directory and using X: in MAINTAINERS to exclude the
emulated ones makes sense to me. The layout will be adjusted in
the next version.
