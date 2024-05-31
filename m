Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA35E33993;
	Fri, 31 May 2024 08:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717143326; cv=none; b=Omf8AGJTIn+IucJwzmD55zfQ5ddDPc83R5FTp7kPHNTPadDz1ry907z1uYA/aClgbvwRYsml6h9WhjjHNwZ288slDPGHkE3hHyA4M2Ap6u8Z5eSKL6SS09J9+i6G8phD2+s7ASoDEX2qBVwq4h9WAKTzdtd7S2I0FWEeOtoidoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717143326; c=relaxed/simple;
	bh=k7QyQ7TkGUcHwLiFEt0d/sOMzmIDJutWfV7hNYcf3Dg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VXhU/cqUJqRQcabQSQz5JdgHLubWH629xfHcHRFbJwcuNuOYh+L6LxmsIwAT5GsKH1tUVkYTIBzeAIEbDX4Jucdi+XFGOAVIegQLWswBoO15j6VDzcj4/+K2KIImXnhAPutCYiSLWYBBPubqGPHd1raXtYiJgPLtRP1BQ3upbVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=pOpvr0Wg; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="pOpvr0Wg"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717143315; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=KrE+QNrLfE3lD8+XaYVhZzwPpPd8oIOnD9OVItqNCRI=;
	b=pOpvr0Wg1zexee18JHA73wCRSejVHvC7tAiQPF6xzEmB9yaqZyCZoa+UtYZcXhb7TyTfo5EMWG1pvTGpG/xQutBzuBi531+Uktm2w+yNkgOFS+Q9gU1dk8bgxxM16VfpO065+VaKhZfm/btiHHS+pYhpInBwOT0RU85idzkA8R8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=guangguan.wang@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W7ZFed3_1717143311;
Received: from 30.221.101.65(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0W7ZFed3_1717143311)
          by smtp.aliyun-inc.com;
          Fri, 31 May 2024 16:15:14 +0800
Message-ID: <e2d0dae7-827e-41f8-bcd5-7d10fd7df594@linux.alibaba.com>
Date: Fri, 31 May 2024 16:15:10 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/2] Change the upper boundary of SMC-R's snd_buf
 and rcv_buf to 512MB
To: Wenjia Zhang <wenjia@linux.ibm.com>, jaka@linux.ibm.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: kgraul@linux.ibm.com, alibuda@linux.alibaba.com,
 tonylu@linux.alibaba.com, guwen@linux.alibaba.com,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240528135138.99266-1-guangguan.wang@linux.alibaba.com>
 <328ea674-0904-4c81-a6e2-7be3420ad578@linux.ibm.com>
Content-Language: en-US
From: Guangguan Wang <guangguan.wang@linux.alibaba.com>
In-Reply-To: <328ea674-0904-4c81-a6e2-7be3420ad578@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024/5/30 00:28, Wenjia Zhang wrote:
> 
> 
> On 28.05.24 15:51, Guangguan Wang wrote:
>> SMCR_RMBE_SIZES is the upper boundary of SMC-R's snd_buf and rcv_buf.
>> The maximum bytes of snd_buf and rcv_buf can be calculated by 2^SMCR_
>> RMBE_SIZES * 16KB. SMCR_RMBE_SIZES = 5 means the upper boundary is 512KB.
>> TCP's snd_buf and rcv_buf max size is configured by net.ipv4.tcp_w/rmem[2]
>> whose defalut value is 4MB or 6MB, is much larger than SMC-R's upper
>> boundary.
>>
>> In some scenarios, such as Recommendation System, the communication
>> pattern is mainly large size send/recv, where the size of snd_buf and
>> rcv_buf greatly affects performance. Due to the upper boundary
>> disadvantage, SMC-R performs poor than TCP in those scenarios. So it
>> is time to enlarge the upper boundary size of SMC-R's snd_buf and rcv_buf,
>> so that the SMC-R's snd_buf and rcv_buf can be configured to larger size
>> for performance gain in such scenarios.
>>
>> The SMC-R rcv_buf's size will be transferred to peer by the field
>> rmbe_size in clc accept and confirm message. The length of the field
>> rmbe_size is four bits, which means the maximum value of SMCR_RMBE_SIZES
>> is 15. In case of frequently adjusting the value of SMCR_RMBE_SIZES
>> in different scenarios, set the value of SMCR_RMBE_SIZES to the maximum
>> value 15, which means the upper boundary of SMC-R's snd_buf and rcv_buf
>> is 512MB. As the real memory usage is determined by the value of
>> net.smc.w/rmem, not by the upper boundary, set the value of SMCR_RMBE_SIZES
>> to the maximum value has no side affects.
>>
> Hi Guangguan,
> 
> That is correct that the maximum buffer(snd_buf and rcv_buf) size of SMCR is much smaller than TCP's. If I remember correctly, that was because the 512KB was enough for the traffic and did not waist memory space after some experiment. Sure, that was years ago, and it could be very different nowadays. But I'm still curious if you have any concrete scenario with performance benchmark which shows the distinguish disadvantage of the current maximum buffer size.
> 

Hi Wenjia,

The performance benchmark can be "Wide & Deep Recommender Model Training in TensorFlow" (https://github.com/NVIDIA/DeepLearningExamples/tree/master/TensorFlow/Recommendation/WideAndDeep).
The related paper here: https://arxiv.org/pdf/1606.07792.

The performance unit is steps/s, where a higher value indicates better performance.

1) using 512KB snd_buf/recv_buf for SMC-R, default(4MB snd_buf/6MB recv_buf) for TCP:
 SMC-R performance vs TCP performance = 24.21 steps/s vs 24.85 steps/s

ps smcr stat:
RX Stats
  Data transmitted (Bytes)    37600503985 (37.60G)
  Total requests                   677841
  Buffer full                       40074 (5.91%)
            8KB    16KB    32KB    64KB   128KB   256KB   512KB  >512KB
  Bufs        0       0       0       0       0       0       4       0
  Reqs   178.2K  12.69K  8.125K  45.71K  23.51K  20.75K  60.16K       0
TX Stats
  Data transmitted (Bytes)   118471581684 (118.5G)
  Total requests                   874395
  Buffer full                      343080 (39.24%)
  Buffer full (remote)             468523 (53.58%)
  Buffer too small                 607914 (69.52%)
  Buffer too small (remote)        607914 (69.52%)
            8KB    16KB    32KB    64KB   128KB   256KB   512KB  >512KB
  Bufs        0       0       0       0       0       0       4       0
  Reqs   119.7K  3.169K  2.662K  5.583K  8.523K  21.55K  34.58K  318.0K

worker smcr stat:
RX Stats
  Data transmitted (Bytes)   118471581723 (118.5G)
  Total requests                   835959
  Buffer full                       99227 (11.87%)
            8KB    16KB    32KB    64KB   128KB   256KB   512KB  >512KB
  Bufs        0       0       0       0       0       0       4       0
  Reqs   125.4K  13.14K  17.49K  16.78K  34.27K  34.12K  223.8K       0
TX Stats
  Data transmitted (Bytes)    37600504139 (37.60G)
  Total requests                   606822
  Buffer full                       86597 (14.27%)
  Buffer full (remote)             156098 (25.72%)
  Buffer too small                 154218 (25.41%)
  Buffer too small (remote)        154218 (25.41%)
            8KB    16KB    32KB    64KB   128KB   256KB   512KB  >512KB
  Bufs        0       0       0       0       0       0       4       0
  Reqs   323.6K  13.26K  6.979K  50.84K  19.43K  14.46K  8.231K  81.80K

2) using 4MB snd_buf and 6MB recv_buf for SMC-R, default(4MB snd_buf/6MB recv_buf) for TCP:
 SMC-R performance vs TCP performance = 29.35 steps/s vs 24.85 steps/s

ps smcr stat:
RX Stats
  Data transmitted (Bytes)   110853495554 (110.9G)
  Total requests                  1165230
  Buffer full                           0 (0.00%)
            8KB    16KB    32KB    64KB   128KB   256KB   512KB  >512KB
  Bufs        0       0       0       0       0       0       0       4
  Reqs   340.2K  29.65K  19.58K  76.32K  55.37K  39.15K  7.042K  43.88K
TX Stats
  Data transmitted (Bytes)   349072090590 (349.1G)
  Total requests                   922705
  Buffer full                      154765 (16.77%)
  Buffer full (remote)             309940 (33.59%)
  Buffer too small                  46896 (5.08%)
  Buffer too small (remote)         14304 (1.55%)
            8KB    16KB    32KB    64KB   128KB   256KB   512KB  >512KB
  Bufs        0       0       0       0       0       0       0       4
  Reqs   420.8K  11.15K  3.609K  12.28K  13.05K  26.08K  22.13K  240.3K

worker smcr stat:
RX Stats
  Data transmitted (Bytes)   349072090590 (349.1G)
  Total requests                   585165
  Buffer full                           0 (0.00%)
            8KB    16KB    32KB    64KB   128KB   256KB   512KB  >512KB
  Bufs        0       0       0       0       0       0       0       4
  Reqs   155.4K  13.42K  4.070K  4.462K  3.628K  9.720K  12.01K  165.0K
TX Stats
  Data transmitted (Bytes)   110854684711 (110.9G)
  Total requests                  1052628
  Buffer full                       34760 (3.30%)
  Buffer full (remote)              77630 (7.37%)
  Buffer too small                  22330 (2.12%)
  Buffer too small (remote)          7040 (0.67%)
            8KB    16KB    32KB    64KB   128KB   256KB   512KB  >512KB
  Bufs        0       0       0       0       0       0       0       4
  Reqs   666.3K  38.43K  20.65K  135.1K  54.19K  36.69K  3.948K  56.42K


From the above smcr stat, we can see quantities send/recv with large size more than 512KB, and quantities send blocked due to
buffer full or buffer too small. And when configured with larger send/recv buffer, we get less send block and better performance.

> Thanks,
> Wenjia
> 
>> Guangguan Wang (2):
>>    net/smc: set rmb's SG_MAX_SINGLE_ALLOC limitation only when
>>      CONFIG_ARCH_NO_SG_CHAIN is defined
>>    net/smc: change SMCR_RMBE_SIZES from 5 to 15
>>
>>   net/smc/smc_core.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
