Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E571B2248BE;
	Tue,  3 Mar 2026 18:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772562714; cv=none; b=HlIpVl53jTs/05OlaiY4FRIcfiUd69jq3ul57ZTsQVUkLCx8Kz8pXEdzw8inf56gbUjZj2L/tbBTUJzFzoX4JSgLeBkEkJLEYcC3Ap7fxqX0A9CKZTmVVeCJpfBrFlByw7fOY9jGehITAHkOY7+UTpQRYL/lri9S5MaD7RDZ6ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772562714; c=relaxed/simple;
	bh=cE8hj3xZNpwmvhdI2EtzrfjZNWOrdjETcbAXx1KdfeA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=jeD8uML4XB6QfA/OxVPv6GTIjvYGbTzkTVeE57B+fax//3ZJliBDnqyd704w2zhU5KSFsR8MBedRH8zFRWNGZ5+5kfuYaJL2BA2LujUccRRnLfU83H0wsF03fjCH8HJM3Q7eePD+i+OkIWtIE9kiRZ4zqYNJz/DwI4JT0/gERXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BAl7IrQm; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BAl7IrQm"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 623635dF2073025;
	Tue, 3 Mar 2026 18:31:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=flArwbIomgdiyQBnayYzxmAOJOOt
	CnUSFXr6mzUZYBA=; b=BAl7IrQmeejwjxXP9UM/7rGpnuopr/8XrQ6KH6OgpmSY
	qzVs3j0GrkWroHNM1uAuMIkxv7vc+Q7Kptv3R5QPnbBOY/AxSC5nWau4taILuvAi
	FAeTIAgsyony/Hb+tSwb+Z4UaJ38yOFO3eDF0bL70Z19kigwfCGQrrafwaxrVOnq
	6ykDiNcXZnbEAbzf5qemkOgWmUURk5Y9nFimv6ODUW0x3Lwri951swi4e9IpojWq
	DcNgwbuKb6BjpY2vJfB2X+aUyyzp2gAf3Pn7W4TBNsheM5UwzjjZaGSaoTDDThyu
	FJvEylvZH3dVX7+WcUfhTdSg+JxEot2poKxANVlsfg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ckssmm3ex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Mar 2026 18:31:48 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 623Hl8Vn029748;
	Tue, 3 Mar 2026 18:31:47 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cmaps3q1g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Mar 2026 18:31:47 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 623IVkvC1638924
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Mar 2026 18:31:46 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 80D8858055;
	Tue,  3 Mar 2026 18:31:46 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1BB8F5804B;
	Tue,  3 Mar 2026 18:31:45 +0000 (GMT)
Received: from [9.111.179.164] (unknown [9.111.179.164])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  3 Mar 2026 18:31:44 +0000 (GMT)
Message-ID: <af549a19-db99-4b16-8511-bf315177a13e@linux.ibm.com>
Date: Tue, 3 Mar 2026 19:31:41 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Mikhail Zaslonko <zaslonko@linux.ibm.com>
Subject: [linux-next][s390] Boot hang after merge c50f05bd3c4e (sched/hrtick)
To: linux-next@vger.kernel.org, linux-s390@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>
Cc: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Egorenkov <egorenar@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDE0NiBTYWx0ZWRfXzB6j70MPijjz
 m+kfznsp3VyKIU8cdsBzF2QAqA/sT+6dpjDwAR9BnhQGRCHdT81ANxIfkZnLXqmErCbuLh98XCh
 6NyXqEWFY5pb+bbBDWfQTNJEG8t0zpQHPNCcTzGJJ0UgF5spWa0/WKrypGzcQo3fS58G0PKOUGO
 6f3D4tVTa4/MC2+S1NudBnINHyyUdknr8qm3PbuJZqfJNso+m728yBoI/4HC7kvbLTPLr9Fm9Ky
 ox9a0th2Z9Mg27amASbter/ORG5DdNkJXge639f7HWi4PaiEwlGpxyaNwV6GU5T9+zKLA5cSbNd
 1ItaoFPPYRv01PP5AiAY3RQ8ri47BDHTf8N0L/J4VAGNneipUZquld2BjhW6k7JOZdf0GnTadm0
 F1w0jcpSj0UsAOcWmt9VVA2E8jBo7n19fqcPuYKF5RdsycaqsoCs30p0EDXc3KnNsx9lFeVfh8D
 O1Fgtvc5MqGX0ryhqOg==
X-Proofpoint-ORIG-GUID: Ju7QjUeyQrPXf8mGnyUf4ffywUUDe7nd
X-Proofpoint-GUID: Ju7QjUeyQrPXf8mGnyUf4ffywUUDe7nd
X-Authority-Analysis: v=2.4 cv=AobjHe9P c=1 sm=1 tr=0 ts=69a72914 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=0_ASNqFNZH2Cd-dCTPQA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-03_02,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 spamscore=0 clxscore=1011 suspectscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603030146

Hello,

we have kernel-next boot hang on s390 starting next-20260302.

I bisected it in linux-next to:

c50f05bd3c4e ("Merge branch into tip/master: 'sched/hrtick'")

Good:
  72a2ab46f045  
  d50da4b5915f  (2nd parent: sched/hrtick branch)

Bad:
  c50f05bd3c4e  (merge commit)

Environment:
 - s390 under z/VM
 - many CPUs defined (32+)
 - boot hangs early with RCU stall (see boot log excerpt below)



[    0.953192] Freeing unused kernel image (initmem) memory: 2520K                                                     
[    0.962509] Write protected read-only-after-init data: 188k                                                         
[    0.962884] Checked W+X mappings: passed, no W+X pages found                                                        
[    0.962888] Run /init as init process                                                                               
 P+q6E616D65 \[   29.503589] systemd[1]: Inserted module 'autofs4'                                                     
                                                                                                                       
hangs here, no logs ...                                                                                                                       
                                                                                                                       
[   98.619693] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:                                                     
[   98.619708] rcu:     4-...!: (1 GPs behind) idle=04a8/0/0x0 softirq=25/26 fqs=0 (false positive?)                   
[   98.619715] rcu:     5-...!: (1 GPs behind) idle=04b8/0/0x0 softirq=25/26 fqs=0 (false positive?)                   
[   98.619720] rcu:     6-...!: (1 GPs behind) idle=04a8/0/0x0 softirq=23/24 fqs=0 (false positive?)                   
[   98.619724] rcu:     7-...!: (1 GPs behind) idle=04e8/0/0x0 softirq=28/29 fqs=0 (false positive?)                   
[   98.619729] rcu:     8-...!: (1 GPs behind) idle=0568/0/0x0 softirq=27/28 fqs=0 (false positive?)                   
[   98.619733] rcu:     9-...!: (1 GPs behind) idle=04e8/0/0x0 softirq=35/36 fqs=0 (false positive?)                   
[   98.619737] rcu:     10-...!: (1 GPs behind) idle=0518/0/0x0 softirq=33/34 fqs=0 (false positive?)                  
[   98.619742] rcu:     11-...!: (1 GPs behind) idle=0448/0/0x0 softirq=22/23 fqs=0 (false positive?)                  
[   98.619745] rcu:     12-...!: (1 GPs behind) idle=0488/0/0x0 softirq=23/24 fqs=0 (false positive?)                  
[   98.619749] rcu:     13-...!: (1 GPs behind) idle=04a8/0/0x0 softirq=22/23 fqs=0 (false positive?)                  
[   98.619753] rcu:     14-...!: (0 ticks this GP) idle=0498/0/0x0 softirq=26/26 fqs=0 (false positive?)               
[   98.619758] rcu:     15-...!: (1 GPs behind) idle=0448/0/0x0 softirq=22/23 fqs=0 (false positive?)                  
[   98.619762] rcu:     16-...!: (1 GPs behind) idle=0458/0/0x0 softirq=22/23 fqs=0 (false positive?)                  
[   98.619766] rcu:     17-...!: (1 GPs behind) idle=0438/0/0x0 softirq=21/22 fqs=0 (false positive?)                  
[   98.619770] rcu:     18-...!: (1 GPs behind) idle=03e8/0/0x0 softirq=22/23 fqs=0 (false positive?)                  
[   98.619774] rcu:     19-...!: (1 GPs behind) idle=0458/0/0x0 softirq=22/23 fqs=0 (false positive?)                  
[   98.619778] rcu:     20-...!: (1 GPs behind) idle=04b8/0/0x0 softirq=24/25 fqs=0 (false positive?)                  
[   98.619782] rcu:     21-...!: (1 GPs behind) idle=04b8/0/0x0 softirq=23/24 fqs=0 (false positive?)                  
[   98.619786] rcu:     22-...!: (1 GPs behind) idle=04d8/0/0x0 softirq=23/24 fqs=0 (false positive?)                  
[   98.619790] rcu:     23-...!: (1 GPs behind) idle=0b68/0/0x0 softirq=29/30 fqs=0 (false positive?)                  
[   98.619794] rcu:     24-...!: (1 GPs behind) idle=0508/0/0x0 softirq=25/26 fqs=0 (false positive?)                  
[   98.619798] rcu:     25-...!: (1 GPs behind) idle=10c8/0/0x0 softirq=38/39 fqs=0 (false positive?)                  
[   98.619802] rcu:     28-...!: (1 GPs behind) idle=0518/0/0x0 softirq=25/26 fqs=0 (false positive?)                  
[   98.619806] rcu:     30-...!: (1 GPs behind) idle=0518/0/0x0 softirq=20/21 fqs=0 (false positive?)                  
[   98.619810] rcu:     31-...!: (1 GPs behind) idle=0528/0/0x0 softirq=23/24 fqs=0 (false positive?)                  
[   98.619815] rcu:     (detected by 0, t=69116 jiffies, g=-1019, q=494 ncpus=32)                                      
[   98.619818] Task dump for CPU 4:       
[   98.619820] task:swapper/4       state:R  running task     stack:0     pid:0     tgid:0     ppid:1      task_flags:0x4200042 flags:0x0
[   98.619825] Call Trace:                                                                                                               
[   98.619828]  [<000001b02c9afd98>] 0x1b02c9afd98                                                                                       
[   98.619834] Task dump for CPU 5:                                                                                                      
[   98.619835] task:swapper/5       state:R  running task     stack:0     pid:0     tgid:0     ppid:1      task_flags:0x4200042 flags:0x0
[   98.619838] Call Trace:                                                                                                               
[   98.619839]  [<000001b02c9b7d98>] 0x1b02c9b7d98                                                                                       
[   98.619841] Task dump for CPU 6:                                                                                                      

...
                                                                                                 
[   98.619963] Task dump for CPU 31:                                                                                                                     
[   98.619964] task:swapper/31      state:R  running task     stack:0     pid:0     tgid:0     ppid:1      task_flags:0x4200042 flags:0x00001000         
[   98.619967] Call Trace:                                                                                                                               
[   98.619967]  [<000001b02ca87d98>] 0x1b02ca87d98                                                                                                       
[   98.619969] rcu: rcu_sched kthread timer wakeup didn't happen for 69113 jiffies! g-1019 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402                         
[   98.620052] rcu:     Possible timer handling issue on cpu=3 timer-softirq=12                                                                          
[   98.620055] rcu: rcu_sched kthread starved for 69116 jiffies! g-1019 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=3                                    
[   98.620058] rcu:     Unless rcu_sched kthread gets sufficient CPU time, OOM is now expected behavior.                                                 
[   98.620060] rcu: RCU grace-period kthread stack dump:                                                                                                 
[   98.620062] task:rcu_sched       state:I stack:0     pid:15    tgid:15    ppid:2      task_flags:0x208040 flags:0x00000000                            
[   98.620067] Call Trace:                                                                                                                               
[   98.620068]  [<000002302d9d58ac>] __schedule+0x35c/0x850                                                                                              
[   98.620077]  [<000002302d9d5ddc>] schedule+0x3c/0xc0                                                                                                  
[   98.620080]  [<000002302d9de418>] schedule_timeout+0x88/0x120                                                                                         
[   98.620084]  [<000002302cbfd29a>] rcu_gp_fqs_loop+0x69a/0x8a0                                                                                         
[   98.620090]  [<000002302cc03426>] rcu_gp_kthread+0x2d6/0x340                                                                                          
[   98.620093]  [<000002302cb82d18>] kthread+0x148/0x170                                                                                                 
[   98.620098]  [<000002302cb01ffc>] __ret_from_fork+0x3c/0x240                                                                                          
[   98.620103]  [<000002302d9dfb82>] ret_from_fork+0xa/0x30                                                                                              
[   98.620106] rcu: Stack dump where RCU GP kthread last ran:                                                                                            
[   98.620108] Task dump for CPU 3:                                                                                                                      
[   98.620110] task:swapper/3       state:R  running task     stack:0     pid:0     tgid:0     ppid:1      task_flags:0x4200042 flags:0x00001000         
[   98.620114] Call Trace:                                                                                                                                                 




