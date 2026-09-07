Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4764B0494;
	Mon,  7 Sep 2026 12:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788785735; cv=none; b=bJI8gVkClD6aYofrIXyQkMSD5ZNmx5Ixhgu8w2UnK8rmyqfYSh42GsAC9PcTAvI74fCh6reU8ZAVJdcBBJjCysN6+zAre1r0JkXXUoNmSfET1dYco7jrt7ikiqv5i6jxdnabbiHVR5gMICb0z0zPY8DMGWbQH4MqLRGoE2ZRNkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788785735; c=relaxed/simple;
	bh=1dDfNap5rRQ1W2ITxZNyZ4dYag8d6/uBDIlvAyexnYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ToHg8/5wiC4NTgrOaS8XXjH8JpCX/W9lsbFugaMhGAmmK7Qhn0cFai6a2ZuBhYseE8A1FRKsNnGOpUe45KkzYVk5hZq7rViIkmOkyaNELjSRPKJHIy3/iSIt8wo9xzVkA51kkcCfjLTSCZQWc6Lxa/2xGTtKib+qe/sMlYoIu8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=f/QecW3Q; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="f/QecW3Q"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 687B1SCq1778468;
	Mon, 7 Sep 2026 12:55:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Csi7Hw
	QhP036lAM+Ru/v+fSgjw9hVgEibUCVAWp81BY=; b=f/QecW3Qmd9EIzGLR+rVbS
	sAWBOTVybWaucGO+evU7loPXKP4hyqUyeuRMxjFx7vmDFMaPdK9hvmJb/sZNGTGu
	c9bf0oyLnW5j5Q8y4OOy8tzONaTAxuKyFIfLc9unqBC19ZAhfygDGmp3yldeCb+7
	V5xV7B0FEa7TP7NLOXsZTwFL9U7sv9hb4cz47EJlrcVjrLAXJvFEA+Ei2yJOCeQd
	EDJ5U2GUmThSmt8swF1fZ3hq5PhO17fpQZDCxQwcWQauFwNwEyjjwpA6dHVyo5ln
	EKAvOK90e+xAn9bwjW8n0Uj52hBUqafE9/Pcf2zI9vcmX87jkRmBrNjGN209OdGA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbhkgtpd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Sep 2026 12:55:22 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 687CfJB2029768;
	Mon, 7 Sep 2026 12:55:21 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ggwdq6508-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Sep 2026 12:55:21 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 687CtHFT46924082
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 7 Sep 2026 12:55:17 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F0F6B20049;
	Mon,  7 Sep 2026 12:55:16 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A1FC920040;
	Mon,  7 Sep 2026 12:55:08 +0000 (GMT)
Received: from [9.61.245.29] (unknown [9.61.245.29])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  7 Sep 2026 12:55:08 +0000 (GMT)
Message-ID: <7a192ab6-d8c7-4823-b569-658c1c0f76af@linux.ibm.com>
Date: Mon, 7 Sep 2026 18:25:06 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] s390/qeth: allow bridgeport queries despite
 OS_MISMATCH
To: netdev-bot+sashiko@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, wintera@linux.ibm.com,
        pasic@linux.ibm.com, aswin@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, Eugene.Crosser@ru.ibm.com,
        ubraun@linux.vnet.ibm.com, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, stable@vger.kernel.org
References: <20260901155344.3561483-1-nagamani@linux.ibm.com>
 <178863834632.219967.10151398782993596479@kernel.org>
Content-Language: en-US
From: Nagamani PV <nagamani@linux.ibm.com>
In-Reply-To: <178863834632.219967.10151398782993596479@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDEzOSBTYWx0ZWRfX+WFIqCNPfeu2
 4AmIDsCl5BnyV9w5siGsuWrN4quaYnKn16RU4SGrwl7k30SzdqYEUKMMS+t3M810e76Dg4B/3V/
 FhijUOlOEradsriho7G8DFPJ9/E6PHE=
X-Proofpoint-ORIG-GUID: g2M_iozXlb-lYL_FT3_AdPjobl3knIS1
X-Authority-Analysis: v=2.4 cv=NMDlPU6g c=1 sm=1 tr=0 ts=6a9eb43b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=8Fpi8FWupL010RkRYMUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDEzOSBTYWx0ZWRfX45uDBMjFz3e0
 V5Eg8wdkORqhvDd4SPrQ6xrcxHI3DE4EStunEueZ6H/jGw6AV4No6haFQDk2stMDYmkpyWoMFZJ
 yupz45wJ9bqLLM1mrzp/JWYI/THaBxrp3WY3eI067rT4vQhUMEnEjewO1pa1pDbnjLYa+et1RR9
 F0YNSuxjZJrpdI7zwCcO39FDoL4nPQpRRdSdqFYxrDxt4ezdGwVKLJTXve83KsuJB0MxgxKrPN/
 OmmvKubqg+0AByBKeQ/JraP1x+McSBfVKqvLRuS3Ttv9N3IuJIjZFW0nmRJTc8b2huLgSCQ/HK7
 +iExhB3TasFBbtNubr2nS0Izwo3JYPDb8bsIbzCwX6EceUKM3Qtg7lmmmH/8J6a2xhIu9hlfpqr
 F8diLsYWwx/UizkvKlp5zbMWSp3OQZ+9CVDxQs//CNZMKlRl5wapNvONZJwgQQy+4JFI0Cj18+4
 XpfZ3V+l/DE8ZVZ/AIQ==
X-Proofpoint-GUID: I_aazv1YbmSP99TmsYZD6SH0nghi1PpF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_03,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 lowpriorityscore=0 clxscore=1011 adultscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070139



On 06/09/26 1:29 AM, netdev-bot+sashiko@kernel.org wrote:

Thank you for the careful review. Addressing each point below.

> 
> [Severity: Medium]
> Should this test also be qualified with IS_IQD(card)?
>
>     IPA_RC_SBP_IQD_OS_MISMATCH = 0x0010,
>     IPA_RC_SBP_OSA_OS_MISMATCH = 0x2B10,
>
> On an OSA (non-IQD) card, a reply carrying ipa_rc == 0 and sbp_rc ==
> 0x0010 is not an OS mismatch in the OSA numbering, yet the new shortcut
> turns it into success...

OSA devices cannot reach qeth_bridgeport_query_ports_cb(). Commit
cdf8df5b42e7 ("s390/qeth: don't offer .ndo_bridge_* ops for OSA
devices") removed ndo_bridge_getlink and ndo_bridge_setlink from the
OSA netdev ops entirely. Its commit message states:
"qeth_l2_bridge_getlink() and qeth_l2_bridge_setlink() will always
return -EOPNOTSUPP on OSA devices."

qeth_l2_detect_dev2br_support() also confirms this: it returns
immediately for non-IQD cards (if (!IS_IQD(card)) return;) and never
sets brport_hw_features on OSA.

There is therefore no call path by which an OSA card can invoke
qeth_bridgeport_query_ports() or reach its callback. The IS_IQD(card)
guard is not needed.
> [Severity: High]
> Can this discard the user's configured bridge port role?
>
> ...qeth_bridgeport_setrole() still fails with -EPERM under mismatch,
> and the following qeth_bridgeport_query_ports(card,
> &card->options.sbp.role, NULL, NULL) now succeeds and overwrites the
> field with "none"...so once the field has been zeroed, no later
> set-online or recovery retries qeth_bridgeport_setrole(), even after
> the other OS family releases the port.

IPA_RC_SBP_IQD_OS_MISMATCH reflects a deliberate configuration:
bridge port ownership on the VCHID is assigned to a different OS
family via z/VM Virtual Switch configuration. This is not a transient
error — it is a permanent topology decision. If the other OS family
releases the bridge port, that is equally a deliberate administrative
action, after which bridge_role would be explicitly reconfigured.

In the deployment this patch fixes, the Linux device observes bridge
port status for visibility but does not own the bridge port.
card->options.sbp.role is NONE before the query. Firmware returns
role=NONE under OS_MISMATCH, so the query writes NONE into NONE: no
user-configured value is clobbered. Confirmed on hardware: cat
bridge_role returns "none (OS family mismatch)" with no impact on
device functionality.

The scenario of a device that previously held an active bridge role
losing it to another OS family, then expecting automatic role
re-application, requires the driver to act as a persistent intent
store across an administrative topology change. That is not the
contract qeth bridge port configuration provides.

> 
> [Severity: Medium]
> Can the value emitted here be written back to the same attribute?
>
> ...a read-modify-write or a save-and-restore of bridge_role by the
> zdev tooling named in the commit message (chzdev save/restore) would
> get -EINVAL...
> 

"none (OS family mismatch)" is only emitted when the card is online
and hardware-reachable. A write-back attempt fails immediately at the
parse step in qeth_bridge_port_role_store() before reaching setrole().
Confirmed on hardware:

  # echo "none (OS family mismatch)" > bridge_role
  -bash: echo: write error: Invalid argument

No configuration is corrupted or discarded.

The patch is correct as submitted. No code changes are needed in
response to these review points. Tested on a HiperSockets IQD device
under OS_MISMATCH: bridge_role reads "none (OS family mismatch)" and
bridge_state is readable, while write attempts to bridge_role are
correctly rejected. The change carries Reviewed-by from Alexandra Winter.

Regards,
Nagamani

