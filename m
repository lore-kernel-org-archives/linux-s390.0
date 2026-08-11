Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F5334040D;
	Tue, 11 Aug 2026 14:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786460240; cv=none; b=boPbhEAW+DpvGUJ6LJRRgD+U3ciyBI/PUt23V0T9DitsWatMo6oleTiZCWai4lG4r5/9f52TraHtNpaqotKe2MZ0NyFCn4h+DIOxvSBMwzfSH+fd0fuN9CpdTu+Am2aBjmqqTl6SUido2WtFXW4SQzpGWkR7Ti35xT9v1SbrgBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786460240; c=relaxed/simple;
	bh=hh6cRLVkiaqtaspBX2a3cT0FetnM2CxpAvk7PkByJ48=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pUTWMyk7nPXDR5/Lv0nQ8m9a5d1RquW8Z7UTOOaVDzbZhgFGb3VGDJydxeWMbFh3xKz2sKtwf2fy711z7r0H+sB7bUwzNj8yftnZqJwrx9K6MorgZUzr/k0Hx1+FFqknx09+kY1VWzReLhKd7NVY8JZlpvtODUrbQOYYir7UoyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YDLBS+Jm; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YDLBS+Jm"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BDWsVE3633567;
	Tue, 11 Aug 2026 14:57:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=CzY665
	t3NBDowK8EC1TP+RAj/yz5qOwYALKEW6bGZQc=; b=YDLBS+Jmnu6x/nNTIqlhTy
	fsR9tu5+CvyoJAKwmK4dZLrMN/cuy+yNj7yGtzHl/zkmd5dLgVEl273ViopXNrXk
	wBptsKsu2Ll09AP5MrdLJEAFTFNn2wS4AJGTB7hAQ44vvhnAOvuN7s4DAapT8YuT
	cbeD1YmeXrpn2lqVGLRHQLMFZNxU9cqOO63C+tGHou36ra0ngzU0iR3qDFhnUQTE
	3r8Gpokv5+4eEbXOYW5vHCmskhgS8Rqrb9GOtykfGNpvc3FLToo4Oda3Be/0atpK
	b+3vlWqANlzhA7CH/cOe7Kr5SRSYxpQBa8+Fn7PRO+BslAPhlLuXCirDQjhfhJcw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fyb23p7mu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 14:57:14 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BEuIn2009280;
	Tue, 11 Aug 2026 14:57:13 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9h1akn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 14:57:13 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67BEvCBm32178878
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 14:57:12 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 75C2F58059;
	Tue, 11 Aug 2026 14:57:12 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF9ED58043;
	Tue, 11 Aug 2026 14:57:10 +0000 (GMT)
Received: from [9.61.146.44] (unknown [9.61.146.44])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Aug 2026 14:57:10 +0000 (GMT)
Message-ID: <5e0c6818-b96d-4c16-85ec-856d880e7ce8@linux.ibm.com>
Date: Tue, 11 Aug 2026 10:57:10 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] s390/vfio-ap: Fix stale do_remove flag across
 iterations in vfio_ap_mdev_cfg_remove
To: Anthony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org, kwankhede@nvidia.com, fiuczy@linux.ibm.com,
        pbonzini@redhat.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        agordeev@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        stable@vger.kernel.org
References: <20260810192257.1208410-1-akrowiak@linux.ibm.com>
 <20260810192257.1208410-2-akrowiak@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260810192257.1208410-2-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a7b384a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=jlkX0w0HnUhOnOpiu7cA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDEyMSBTYWx0ZWRfXyQde4QCeNF+w
 vKoqBRpBScC3KkKSNcgAK/6fK89VJpMMbZnbIJiLuKTdq1JzXU+1Y/G7BCqfAPQka3A+PF1CRN8
 S8QxmNoT1vLdoZ4D2JCke5svfMYiZopIDGHLhVG1TGteg9ZsciZ1PR0GkQ1F0k8jkfCcnEoaPjj
 zaCJ8LTHMsouF1oiq1YDHAt3KR4AsYapI61QJfbmKBGgskjrK3rXjIXnXkTgGpRyPfhbR0bJOLW
 8OeUdheZN1DJgxzNJsfkSoH4paw18nHjWfr2otk2B9NFvila19WWcpUzp+DmCS3oFpygohlbG92
 OoLWKPmqCC8iB4bDdFASoSFVgrQCYyZ1xKdQXQvhivAb5DaU2JNJbdSt5P0Az0ywzo9gPHo7YfS
 5jFh19OaQz0EzRLzyYrhJjfUj3TkI00fpglS6OSOqSC2jkjyqQM3UlYWqgYLLV5woMKH8zgzEHy
 IOfUxOyRbeLEZuPeA6w==
X-Proofpoint-ORIG-GUID: y0jkhEWdjeCL9NtTUKU1OEa7gdrzciwH
X-Proofpoint-GUID: y0jkhEWdjeCL9NtTUKU1OEa7gdrzciwH
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDEyMSBTYWx0ZWRfX1Y99OdRPOWfc
 AJMXE3sl7LyzYrly+tzJnJCdNRGlinwaCQtmlqXtY4xB2TAzlQvRCnWmRLgLgSz8RT4gkg2YBCH
 Z5H15Q/mQlvGrxemZaNrNb4wu46NVE8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110121

On 8/10/26 3:22 PM, Anthony Krowiak wrote:
> The do_remove flag in vfio_ap_mdev_cfg_remove() is initialised to zero
> before the loop that iterates over the list of matrix mdevs, but is
> never reset at the start of each iteration. Since do_remove is
> OR-accumulated across iterations, a positive result from one mdev
> carries over to subsequent mdevs.
> 
> The fix is to set the do_remove flag with the first call to bitmap_and;
> for example: do_remove = bitmap_an rather than do_remove |= bitmap_and.
> 
> Fixes: eeb386aeb5b7 ("s390/vfio-ap: handle config changed and scan complete notification")
> Cc: stable@vger.kernel.org
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>


