Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37A7770FD;
	Fri, 31 May 2024 09:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717146215; cv=none; b=JFUiNqikYv4+9i8nkANMFDuZElYz2B6OszOFCWqWTynKlHCReGqxVPcb+0bxPIX/nKeNWsR5OyFwJDAYp613QwzskAH19Ld/Xqn+vxMUar/0lEd57zl53II4y8Q9avP/DW1HuebBXbxTi+X9KXY1PB22TUcXkk+C7MIN7oQ9kVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717146215; c=relaxed/simple;
	bh=S0ZKYYnPoHPKYkKOnAkf25zs6aVUOp2ahpjN8lCEaOg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=M5j9dP8IPDCSt+vtN+SPxqw/XUL9Q/xmDitdiL6PzLQwLSbLlBP/tP+4IOdioNKBc8mb7mm8Y1MHum7h3kd0bNu1c0IKRsb4RGRXR/xmCGUPkeOXpjqNHaF4QL85w0yrKbej5fbth7wjcQt1zz/udK0AzJApEKQSi88/Dp5OMv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oyuFEjCX; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oyuFEjCX"
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44V8Pllt005650;
	Fri, 31 May 2024 09:03:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=pp1;
 bh=XydXLZ2izbHKZATJ4GMzAav3AkDiEapDJQW2XKsdEDE=;
 b=oyuFEjCXTagFnA/OGazviomD5ka/oUQd+lq+gup2Ax6qeeB0YeLKqblXki480GxEAV0V
 FwXgzlYvsW4xO7h8y3gikx7QfpphY8s5ObeQCvitewLGseG/A5oppgRZbDBKNrBvY9qh
 kkgS3BQei/yFPZyRfGt8XLWAXBJpvjtp2RdnN9q/a9os54ynoK8hNLQncuGukf9svPvu
 ux8IQz8oFgR5OK5QTOafkp5LpCERUBT97bcRbJMFuuitr+ds45kZfvGBY8q2uBQEW+6H
 E1ZMEubB9WRSu3yDhGchqUZ+0WE6+LXyr/y/dA3lgQmsrwFG/Dm+dEHaQk3wZdFOLg8c SQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yfaatr6jx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 09:03:27 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44V93Q9s031992;
	Fri, 31 May 2024 09:03:26 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yfaatr6jt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 09:03:26 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 44V8jkoM029003;
	Fri, 31 May 2024 09:03:25 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ydpayy168-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 09:03:25 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 44V93MDu29164142
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 May 2024 09:03:24 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3AC4158065;
	Fri, 31 May 2024 09:03:22 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BBD815804B;
	Fri, 31 May 2024 09:03:19 +0000 (GMT)
Received: from [9.171.25.186] (unknown [9.171.25.186])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 May 2024 09:03:19 +0000 (GMT)
Message-ID: <0f590cb7-9b67-4dce-93a4-5da89812a075@linux.ibm.com>
Date: Fri, 31 May 2024 11:03:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/2] Change the upper boundary of SMC-R's snd_buf
 and rcv_buf to 512MB
To: Guangguan Wang <guangguan.wang@linux.alibaba.com>, jaka@linux.ibm.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc: kgraul@linux.ibm.com, alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        guwen@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240528135138.99266-1-guangguan.wang@linux.alibaba.com>
 <328ea674-0904-4c81-a6e2-7be3420ad578@linux.ibm.com>
 <e2d0dae7-827e-41f8-bcd5-7d10fd7df594@linux.alibaba.com>
Content-Language: en-US
From: Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <e2d0dae7-827e-41f8-bcd5-7d10fd7df594@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wgKl3mqkdsnyIbOV6nixZhSNyYNUSMOi
X-Proofpoint-ORIG-GUID: GWWSKTeXVKpKorl7dO_hdR4akTS0zHmz
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-31_05,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=999
 mlxscore=0 impostorscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 priorityscore=1501 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405310066



On 31.05.24 10:15, Guangguan Wang wrote:
> 
> 
> On 2024/5/30 00:28, Wenjia Zhang wrote:
>>
>>
>> On 28.05.24 15:51, Guangguan Wang wrote:
>>> SMCR_RMBE_SIZES is the upper boundary of SMC-R's snd_buf and rcv_buf.
>>> The maximum bytes of snd_buf and rcv_buf can be calculated by 2^SMCR_
>>> RMBE_SIZES * 16KB. SMCR_RMBE_SIZES = 5 means the upper boundary is 512KB.
>>> TCP's snd_buf and rcv_buf max size is configured by net.ipv4.tcp_w/rmem[2]
>>> whose defalut value is 4MB or 6MB, is much larger than SMC-R's upper
>>> boundary.
>>>
>>> In some scenarios, such as Recommendation System, the communication
>>> pattern is mainly large size send/recv, where the size of snd_buf and
>>> rcv_buf greatly affects performance. Due to the upper boundary
>>> disadvantage, SMC-R performs poor than TCP in those scenarios. So it
>>> is time to enlarge the upper boundary size of SMC-R's snd_buf and rcv_buf,
>>> so that the SMC-R's snd_buf and rcv_buf can be configured to larger size
>>> for performance gain in such scenarios.
>>>
>>> The SMC-R rcv_buf's size will be transferred to peer by the field
>>> rmbe_size in clc accept and confirm message. The length of the field
>>> rmbe_size is four bits, which means the maximum value of SMCR_RMBE_SIZES
>>> is 15. In case of frequently adjusting the value of SMCR_RMBE_SIZES
>>> in different scenarios, set the value of SMCR_RMBE_SIZES to the maximum
>>> value 15, which means the upper boundary of SMC-R's snd_buf and rcv_buf
>>> is 512MB. As the real memory usage is determined by the value of
>>> net.smc.w/rmem, not by the upper boundary, set the value of SMCR_RMBE_SIZES
>>> to the maximum value has no side affects.
>>>
>> Hi Guangguan,
>>
>> That is correct that the maximum buffer(snd_buf and rcv_buf) size of SMCR is much smaller than TCP's. If I remember correctly, that was because the 512KB was enough for the traffic and did not waist memory space after some experiment. Sure, that was years ago, and it could be very different nowadays. But I'm still curious if you have any concrete scenario with performance benchmark which shows the distinguish disadvantage of the current maximum buffer size.
>>
> 
> Hi Wenjia,
> 
> The performance benchmark can be "Wide & Deep Recommender Model Training in TensorFlow" (https://github.com/NVIDIA/DeepLearningExamples/tree/master/TensorFlow/Recommendation/WideAndDeep).
> The related paper here: https://arxiv.org/pdf/1606.07792.
> 
> The performance unit is steps/s, where a higher value indicates better performance.
> 
> 1) using 512KB snd_buf/recv_buf for SMC-R, default(4MB snd_buf/6MB recv_buf) for TCP:
>   SMC-R performance vs TCP performance = 24.21 steps/s vs 24.85 steps/s
> 
> ps smcr stat:
> RX Stats
>    Data transmitted (Bytes)    37600503985 (37.60G)
>    Total requests                   677841
>    Buffer full                       40074 (5.91%)
>              8KB    16KB    32KB    64KB   128KB   256KB   512KB  >512KB
>    Bufs        0       0       0       0       0       0       4       0
>    Reqs   178.2K  12.69K  8.125K  45.71K  23.51K  20.75K  60.16K       0
> TX Stats
>    Data transmitted (Bytes)   118471581684 (118.5G)
>    Total requests                   874395
>    Buffer full                      343080 (39.24%)
>    Buffer full (remote)             468523 (53.58%)
>    Buffer too small                 607914 (69.52%)
>    Buffer too small (remote)        607914 (69.52%)
>              8KB    16KB    32KB    64KB   128KB   256KB   512KB  >512KB
>    Bufs        0       0       0       0       0       0       4       0
>    Reqs   119.7K  3.169K  2.662K  5.583K  8.523K  21.55K  34.58K  318.0K
> 
> worker smcr stat:
> RX Stats
>    Data transmitted (Bytes)   118471581723 (118.5G)
>    Total requests                   835959
>    Buffer full                       99227 (11.87%)
>              8KB    16KB    32KB    64KB   128KB   256KB   512KB  >512KB
>    Bufs        0       0       0       0       0       0       4       0
>    Reqs   125.4K  13.14K  17.49K  16.78K  34.27K  34.12K  223.8K       0
> TX Stats
>    Data transmitted (Bytes)    37600504139 (37.60G)
>    Total requests                   606822
>    Buffer full                       86597 (14.27%)
>    Buffer full (remote)             156098 (25.72%)
>    Buffer too small                 154218 (25.41%)
>    Buffer too small (remote)        154218 (25.41%)
>              8KB    16KB    32KB    64KB   128KB   256KB   512KB  >512KB
>    Bufs        0       0       0       0       0       0       4       0
>    Reqs   323.6K  13.26K  6.979K  50.84K  19.43K  14.46K  8.231K  81.80K
> 
> 2) using 4MB snd_buf and 6MB recv_buf for SMC-R, default(4MB snd_buf/6MB recv_buf) for TCP:
>   SMC-R performance vs TCP performance = 29.35 steps/s vs 24.85 steps/s
> 
> ps smcr stat:
> RX Stats
>    Data transmitted (Bytes)   110853495554 (110.9G)
>    Total requests                  1165230
>    Buffer full                           0 (0.00%)
>              8KB    16KB    32KB    64KB   128KB   256KB   512KB  >512KB
>    Bufs        0       0       0       0       0       0       0       4
>    Reqs   340.2K  29.65K  19.58K  76.32K  55.37K  39.15K  7.042K  43.88K
> TX Stats
>    Data transmitted (Bytes)   349072090590 (349.1G)
>    Total requests                   922705
>    Buffer full                      154765 (16.77%)
>    Buffer full (remote)             309940 (33.59%)
>    Buffer too small                  46896 (5.08%)
>    Buffer too small (remote)         14304 (1.55%)
>              8KB    16KB    32KB    64KB   128KB   256KB   512KB  >512KB
>    Bufs        0       0       0       0       0       0       0       4
>    Reqs   420.8K  11.15K  3.609K  12.28K  13.05K  26.08K  22.13K  240.3K
> 
> worker smcr stat:
> RX Stats
>    Data transmitted (Bytes)   349072090590 (349.1G)
>    Total requests                   585165
>    Buffer full                           0 (0.00%)
>              8KB    16KB    32KB    64KB   128KB   256KB   512KB  >512KB
>    Bufs        0       0       0       0       0       0       0       4
>    Reqs   155.4K  13.42K  4.070K  4.462K  3.628K  9.720K  12.01K  165.0K
> TX Stats
>    Data transmitted (Bytes)   110854684711 (110.9G)
>    Total requests                  1052628
>    Buffer full                       34760 (3.30%)
>    Buffer full (remote)              77630 (7.37%)
>    Buffer too small                  22330 (2.12%)
>    Buffer too small (remote)          7040 (0.67%)
>              8KB    16KB    32KB    64KB   128KB   256KB   512KB  >512KB
>    Bufs        0       0       0       0       0       0       0       4
>    Reqs   666.3K  38.43K  20.65K  135.1K  54.19K  36.69K  3.948K  56.42K
> 
> 
>  From the above smcr stat, we can see quantities send/recv with large size more than 512KB, and quantities send blocked due to
> buffer full or buffer too small. And when configured with larger send/recv buffer, we get less send block and better performance.
> 
That is exactly what I asked for, thank you for the details! Please give 
me some days to try by ourselves. If the performance is also significant 
as yours and no other side effect, why not?!
