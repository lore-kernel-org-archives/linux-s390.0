Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF22C2C0303;
	Tue, 28 Jul 2026 14:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785250127; cv=none; b=cnDMQXb6GdkIzBaHK+X0hNS8H2LDP9Gb4gOG0ezjVrRQyjObj8fVU0guJHacvcJy/1SyDv0WpoYoy9W59l3IhUikyLwIKIgnHcxFI4dJqFL6ldcW35JK1lrp3LeclFHjUPtTX3vJfJF3TKgJxjNjGkE2jnLMb8FJEZzryhlbzFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785250127; c=relaxed/simple;
	bh=hVc37V4+KFyhr/kqrYFQobZVgNGJ+8AZOwS+diM7CO0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ewRgHUGedopIZ24Cx9Yf01SLCW3sApTRh7JBVEme8NxII2uN3Sq/DrFaOndW6Os4uTdXc2YwiYPLX8nY0vPrW4GdhFL3TSaJ7be2kmWBV7R1XN/vCLZh2tIJ2ZTHDpvPpl910sWaOewCl9le0NTTYuCsYbKQ9IzbIB9mRglLdso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IO90sMn1; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IO90sMn1"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66SEldJC1380112;
	Tue, 28 Jul 2026 14:48:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Da4qMw
	DTeBrPlMuzFy3/5HHTQeEczRB3Ie5vwRT2g2s=; b=IO90sMn1Bje6miXeeAuz42
	ENrSk+2OQ+0IfZX4Ek3vGQC/BG8RYTCjp3Z0kY/opu3XaKHV8gl232tEZjRblNch
	bMh6yHKgnZ1bQYI1/hxyYVk6SQVhrU11B6/GkCawLTvXVPQqFhZT96BtFI/h/tSE
	9xkucaOgr8w7BIIz6JvD6yJUf12GgajfVHtOd4M9mlkXeje5umgHYMll8V8soc8E
	U5NAKMeHLFepoBEytTBAU+2O/gxJhfCpLushpmvjQAUzbE5PbLRd36M+qDoSZJTb
	meyr9at0z7nKeaUQdEaN2edFuCsSMv+AQfE5iymX3kgirambJjG1etL9kn8qqE+g
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyj56nr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 14:48:44 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66SEfa7l022321;
	Tue, 28 Jul 2026 14:48:43 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn7fqag4x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 14:48:43 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66SEmgLG15270456
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jul 2026 14:48:42 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B694558052;
	Tue, 28 Jul 2026 14:48:42 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 390E55805A;
	Tue, 28 Jul 2026 14:48:42 +0000 (GMT)
Received: from [9.61.157.32] (unknown [9.61.157.32])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Jul 2026 14:48:42 +0000 (GMT)
Message-ID: <52cb86e8-d9da-4b84-9e8b-d46251464793@linux.ibm.com>
Date: Tue, 28 Jul 2026 10:48:41 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 09/10] s390/vfio_ccw: selectively expand io_mutex
To: Eric Farman <farman@linux.ibm.com>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        stable@vger.kernel.org
References: <20260728033022.2658232-1-farman@linux.ibm.com>
 <20260728033022.2658232-10-farman@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260728033022.2658232-10-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDEzMiBTYWx0ZWRfXzqSu2y/2W3Xt
 lXX2Jwe9kV5bXuEO+tNKUJ8iP/3PgYt6D9q7wTp7F9M5kKnQdUvc3wvXNOwhMx9YaJGVNJDWTBN
 k+oHuCTcyU1X/iDPiRI2xcQeK+DCgTg=
X-Proofpoint-GUID: tb4ktdPjPI4hnPMkVj3E_94f3Uo6cpGo
X-Proofpoint-ORIG-GUID: tb4ktdPjPI4hnPMkVj3E_94f3Uo6cpGo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDEzMiBTYWx0ZWRfX1E3BestZi+iJ
 jY33W/suLRY6ZCm8LHII/xPIZLizcCHU6IGgLaBs8HcptDQQJigIbLoRbrh7EMcVLbSZxMQcBhv
 emtp/3AxEAzfcAhV7Od36guuDkosVB94g/Fby2HuBJlAlrndjUeYajA/+TwXjnwN5e2tTBysmFN
 FQfm0i9JxXJ1YXTfJVT3kDqE1IV1h3O5JWk75PWVzRq4eYRedEXejdKEhb7/zFrHos82tSopHay
 mlf30xPSSmRxuU6FgbNLoStSCCOUyL4Zp4G8G+LKJDrT3l3j6x0KzC5XZZE5QFPAwlA3aVbaBNE
 ZqOig8GhsQgBQ8BYN34qowlVN6s/DnLEs2gQo8qm6RXBb7HqGQZmW4yttZmBWjyS8DUfjKHajO1
 MkaCFq8RG8WUINVTuy1ZkCXlhY/9Fh6XeExQrCVhAa/ssaTBqM9Otq/+ISV7UPodaKJkNYNjptg
 doIV7rEKNNmr76dCKQg==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a68c14c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=Pi-cMz3bnQeYMOJVrQsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_04,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607280132

On 7/27/26 11:30 PM, Eric Farman wrote:
> The io_mutex was defined to serialize the io_regions, but then has
> also sort of been associated with the I/O themselves because of
> the close relationship they share.
> 
> With the handful of races that are possible, the choices are either to:
>  A) expand the scope of io_mutex to close these remaining windows, or
>  B) reduce the scope of io_mutex to just io_region, and introduce a new
>     lock mechanism for the remaining I/O resources
> 
> This patch implements A, since B brings with it a lot more interactions
> that would need to be tracked and kept in a correct hierarchy. It also
> takes advantage of the workqueue element for cp_free() that now gets
> called out of fsm_notoper(), which could be invoked out of an interrupt
> context and thus cannot acquire a mutex itself.
> 
> Fixes: 4f76617378ee ("vfio-ccw: protect the I/O region")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Farman <farman@linux.ibm.com>

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>



