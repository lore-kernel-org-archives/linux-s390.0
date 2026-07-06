Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8F839DBFC
	for <linux-s390@vger.kernel.org>; Mon,  6 Jul 2026 07:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783322508; cv=none; b=GVmOrdkpGGJ+gxJ7u925zDqBTC+p7HhAKMQ59DxSFeNtLXOnV42cZyeyvamEMRmvkkXyOLX7sHfjJKKmvE5cZsXsMb1lgiZBH4ocWBj/l4/e6OjUaf688qimdTrd+1umNMZ4K8aCL7TQbubANbcGXUdaw7qYhO5j8hFFSAKtOh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783322508; c=relaxed/simple;
	bh=hRa6QBQcxg9NM0qbrY911cF+4X8xwNxA6ZU9+zgQcYE=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Exk10UTw5wdVHEsE6rd4BcGmACf5RPksXeLkHjHLH2LZzE+0oIpoZ+bFfs8Nyl2zx3+SmIXA5m17Gbg1B36s4KYfwNkkK24xV8+7IOLUbBhNqKWtiOhNPwHLodCcEKnDlmWjeAugdWn61sBxO8nV1LSnmeWWDboKJ0RW0gbJPh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sSi1mX4P; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sSi1mX4P"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 665MIQCm2250692;
	Mon, 6 Jul 2026 07:21:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=opUwRaj7aOIzKyyI6t6AvNTZ0+NEJHYINFDT082qZLY=; b=sSi1mX4PG9uC
	Opkh2Kj0Tx4+p1IA0RXKiiSp/Ii9oj5g1Ut8GkwLOgKJnPoFwWZ0F+/4ULDMm6gC
	J4P56XMh6tRjM5f6jEkwv2GDBmlGyT4qh9z/fhBsuI/4GpaL4VqWRS0KI34rNIXi
	0Ze/6/yOrXueL73P6M84yAXDZjjI5OVKCDFbD57IxRm84VtSVou0T3qRgylNkHZb
	+az6SXcvv7VmBPqsMmJO8ech35K6HTlF/WakZ3BK/ir/ZRHC+PCoakEry+M4l6Yn
	kkvIr4NGwawWF2373FNItpq99gpDzRqfQaggCDgjDSg0+6CDfUI28bBMmM1sfVXJ
	8UgSG8h2Ug==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6qkn8awe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 07:21:33 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6667K0F3026810;
	Mon, 6 Jul 2026 07:21:32 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7e0h4e4q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 07:21:32 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6667LV4j64094608
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 07:21:31 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 516C658056;
	Mon,  6 Jul 2026 07:21:31 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A5C1E58052;
	Mon,  6 Jul 2026 07:21:30 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Jul 2026 07:21:30 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 06 Jul 2026 09:21:30 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
        thuth@redhat.com, berrange@redhat.com, qemu-s390x@nongnu.org,
        qemu-devel@nongnu.org, linux-s390@vger.kernel.org,
        dengler@linux.ibm.com, borntraeger@linux.ibm.com,
        fcallies@linux.ibm.com
Subject: Re: [PATCH v9 03/21] target/s390x: Move cpacf sha512 code into a new
 file
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <877bnckuuk.fsf@redhat.com>
References: <20260701164650.95760-1-freude@linux.ibm.com>
 <20260701164650.95760-4-freude@linux.ibm.com> <877bnckuuk.fsf@redhat.com>
Message-ID: <3ea0066d4b1f2e1e4a604286e49ef12b@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Q/XiJY2a c=1 sm=1 tr=0 ts=6a4b577d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=0eez0NfR2cIk6WOmlF4A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: jn5-VCa8DSmlqjxVeLl1sO_-k4tGEP2c
X-Proofpoint-ORIG-GUID: jn5-VCa8DSmlqjxVeLl1sO_-k4tGEP2c
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA3MSBTYWx0ZWRfX8/eHzDuYoLyy
 hhvw6ZI5iZZ8oEt/mi/ctLDGuecZpXN08PlZROJG9fmkkx6y+Hl+J1oLKebQF5/hJFwiJgQXqd0
 AjSGC3V0EzAf8n9xaaMV630HMMq6v8I=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA3MSBTYWx0ZWRfX9ik1Fus7YcA7
 7lk5tGBr3WnK27T0OM2aBLnDahGUnnKg3/AIlDbKB/ka63mvtopoZggtpUnqzlSu8RsAqT7RMfZ
 VqR9m9GjSceDw1QSSDzVvrIZYIGdyFBb561wrPAGh3mR0GKsoH/5cATr1Rzs5PJSup0WpB2GJZ+
 iB/bjTmVKTIxNVkKE/DxLv33t34E+ukeVxj5jAEoRg6Htuhz1s+Tb+Qgp1c80wTCAlwt0WnYrlf
 /ndVZTpvcG9aLaLDfcDF8rKLbcjJ4XRBMNNbl33gc/B09yJ8iyysGcN32pQvY57iWdqfWGR4wWh
 ZQuJ7but2scbar2VqwDQ7Eiq77BANnVSberzhwbXf6HI2cJ32MU4Pi3R9cHrpA5tMV1VHGnIYeD
 OGdVsKlX5Hl3tS1JGTQd+ZP8URFii+uA1yn36KabhKKYVCHbcTyFzNuspF2ZrvjiePpaocJ0m5D
 0XOctMfNrkMl40TrxCw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060071

On 2026-07-03 16:31, Cornelia Huck wrote:
> On Wed, Jul 01 2026, Harald Freudenberger <freude@linux.ibm.com> wrote:
> 
>> Move the cpacf sha512 implementation into a new file
>> cpacf_sha512.c. Add this new file to the build and use the cpacf.h
>> header file storing function the prototypes.
>> 
>> Tested-by: Holger Dengler <dengler@linux.ibm.com>
>> Reviewed-by: Finn Callies <fcallies@linux.ibm.com>
>> Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
>> ---
>>  target/s390x/tcg/cpacf.h         |   5 +
>>  target/s390x/tcg/crypto_helper.c | 222 
>> -------------------------------
>>  target/s390x/tcg/meson.build     |   1 +
>>  3 files changed, 6 insertions(+), 222 deletions(-)
> 
> Forgot to commit the new cpacf_sha512.c file?

Yes - the last rework ...
Shall I send out v10 with only this missing file fixed ?
