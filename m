Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B483093C6;
	Thu,  5 Mar 2026 07:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772696977; cv=none; b=NpbJhd3/+idIVuO51x1QildFea7M+73b3h1fzphbT4RaX7fdOpFTwCvbmy0QmMwj2/jt4CFvwK1aO5aC8mcSVSfP4rPV2TLtfu7PF/9BhANpHzDz3DypbJmmh4UIJKxjzmM3hCEMXvyjqlDp8qYKstIgLxBpv7LORVyhQ97axfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772696977; c=relaxed/simple;
	bh=S8Nw8Pk5eoRXwBYtjsQA/CDGhjM2WyURc54R9YhWURI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F3GkaeI9Udlup7GIZJq7sxCyqIRy3+n6qrK88KyShZ/o5FyumrNXIPH7AQ5hOWgtrBL8xh5sTw9Gc3v3XwMvpQSMBoaw6K08scNae8+nr5+0QERZKSk3iNRHDsf5tmBx4mgNGxVFBKiTDBSyN8T6Pt1NzWnpK3/aG4HLCJlq4g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZsK3AUKz; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZsK3AUKz"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6257KEh72459770;
	Thu, 5 Mar 2026 07:49:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=uxkMVy5228wC3w2bQRSJYU5S6CRCKK
	Qw8+A7NsBmJtI=; b=ZsK3AUKzRnuGF8lFFtxy/guBw7YNfo/TZca1a3nVn1oxzJ
	WQeBOWKcKe+Pcls23ObyjpmJeC64Yv11p1XhkYqmJgBEM8XUj0hz2w6MK50WP7k0
	NioF2Gg7JIGnXf4MB+AJlWNu3j8BuKcR1R4KXIxgVY7KVlq88SKakBCF7Cz9c/gg
	HCr6tCx2UHMqlyih75wyzcY8F3CQ0yWAuYLydT5TnVI9xBnBL6OslA0r/IFl6zcM
	fWtfFRCZdIYWnu2wfDjeKaHXpi30FtkkSuBiiNdf2POJNPM8iXB2fZtKTZfF7XBo
	osxi0wiK0XKdRxxW3hYHI9BmmN5PB9foAzGXnBbg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ckssmt9rm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Mar 2026 07:49:28 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6254aMmE003266;
	Thu, 5 Mar 2026 07:49:28 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cmb2yabw2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Mar 2026 07:49:28 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6257nNuN15663490
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 5 Mar 2026 07:49:23 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 97AFA2004B;
	Thu,  5 Mar 2026 07:49:23 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6414620049;
	Thu,  5 Mar 2026 07:49:23 +0000 (GMT)
Received: from osiris (unknown [9.52.214.206])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  5 Mar 2026 07:49:23 +0000 (GMT)
Date: Thu, 5 Mar 2026 08:49:22 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Mikhail Zaslonko <zaslonko@linux.ibm.com>
Cc: linux-next@vger.kernel.org, linux-s390@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [linux-next][s390] Boot hang after merge c50f05bd3c4e
 (sched/hrtick)
Message-ID: <20260305074922.7170Ad3-hca@linux.ibm.com>
References: <af549a19-db99-4b16-8511-bf315177a13e@linux.ibm.com>
 <28add480-4841-4e6a-a8a9-1211280ecc51@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28add480-4841-4e6a-a8a9-1211280ecc51@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDA2MCBTYWx0ZWRfX1FmiWc81G7LL
 dysuatnKIr8YIGI4Rm58aemqVFPViy4wvtFt251Ms5z/iaNddncuyU1MNY6Z3aIXfuljwk3qjhU
 WC36OF0Ql7nRqc4UFqgQQmSSck4l8dbdMPQ98CC0SK838ywnENVdIpPJYnYeuiPOwvfXr/jBU67
 /B8pOO35oXV4svIIvA6NkijWQNGXf6DtQwMtGKc49Uv2LqZfmCE7CpvClqsAU+slg1W7NF8eEve
 FX2/bE3hZ5VY9PRb6qZ1OgYG8WWFQv6MwLAa0afhz2qKSQDME3lur+grXS5apWLagQr23BjsVcw
 L50ppMAgA5eTXYd3uVuzv66O59stVUxnA/qq6s4/t9aUW8cxKP5ZJa6EV4lrDwWe6zrPm82DX6W
 5RzkOA03C6tjh2BS3notv6GRl1SpCQI9GF7RhNtPz9jHDi+2plxIDvx7UKdMi32UUGlRDyAQjXl
 us9Q/QikCnzK968k3EA==
X-Proofpoint-ORIG-GUID: vwTyfjVHV3Lnpql7U492-r8NFWivhNDg
X-Proofpoint-GUID: vwTyfjVHV3Lnpql7U492-r8NFWivhNDg
X-Authority-Analysis: v=2.4 cv=AobjHe9P c=1 sm=1 tr=0 ts=69a93588 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=RLuo-xB6GI3gNM6DKHAA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_01,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 spamscore=0 clxscore=1011 suspectscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050060

On Wed, Mar 04, 2026 at 05:13:56PM +0100, Mikhail Zaslonko wrote:
> Sorry, forgot to Cc a few people.
> Adding scheduler maintainers.
> 
> Thanks,
> Mikhail Zaslonko
> 
> On 03-Mar-26 19:31, Mikhail Zaslonko wrote:
> > Hello,
> > 
> > we have kernel-next boot hang on s390 starting next-20260302.
> > 
> > I bisected it in linux-next to:
> > 
> > c50f05bd3c4e ("Merge branch into tip/master: 'sched/hrtick'")
> > 
> > Good:
> >   72a2ab46f045  
> >   d50da4b5915f  (2nd parent: sched/hrtick branch)
> > 
> > Bad:
> >   c50f05bd3c4e  (merge commit)
> > 
> > Environment:
> >  - s390 under z/VM
> >  - many CPUs defined (32+)
> >  - boot hangs early with RCU stall (see boot log excerpt below)

linux-next is currently completely broken because of this.

Looking at one of the numerous dumps of linux-next from 20260303 I can
see that the system hangs early waiting for synchronize_rcu_normal()
to finish:

crash> ps
      PID    PPID  CPU       TASK        ST  %MEM      VSZ      RSS  COMM
>       0       0   0     3b7dff6c700    RU   0.0        0        0  [swapper/0]
>       0       0   1      80afc800      RU   0.0        0        0  [swapper/1]
>       0       0   2      80afa400      RU   0.0        0        0  [swapper/2]
>       0       0   3      80b34800      RU   0.0        0        0  [swapper/3]
>       0       0   4      80b32400      RU   0.0        0        0  [swapper/4]
>       0       0   5      80b30000      RU   0.0        0        0  [swapper/5]
>       0       0   6      80b14800      RU   0.0        0        0  [swapper/6]
>       0       0   7      80b50000      RU   0.0        0        0  [swapper/7]
>       0       0   8      80b3c800      RU   0.0        0        0  [swapper/8]
        1       0   3      80a80000      UN   0.0        0        0  swapper/0

Everything is idle. PID 1 is in uninterruptible sleep:

crash> bt 1
PID: 1        TASK: 80a80000          CPU: 3    COMMAND: "swapper/0"
 #0 [337de307a50] __schedule at 3b7df34708c
 #1 [337de307ac8] schedule at 3b7df3475ec
 #2 [337de307af8] schedule_timeout at 3b7df34fd78
 #3 [337de307b80] __wait_for_common at 3b7df348482
 #4 [337de307c18] wait_for_completion_state at 3b7df348658
 #5 [337de307c38] __wait_rcu_gp at 3b7de561da8
 #6 [337de307c98] synchronize_rcu_normal at 3b7de56ba12
 #7 [337de307d78] kern_unmount at 3b7de8a8f86
 #8 [337de307da8] do_sysctl_args at 3b7de94f2fa
 #9 [337de307e20] kernel_init at 3b7df3448b0
#10 [337de307e38] __ret_from_fork at 3b7de46dffc
#11 [337de307ea0] ret_from_fork at 3b7df3514b2

The corresponding rcu_synchronize structure on the stack:

crash> struct rcu_synchronize 0x337de307d80
struct rcu_synchronize {
  head = {
    next = 0x822a62a8,
    func = 0x3b7de561a90 <wakeme_after_rcu>
  },
  completion = {
    done = 0,
    wait = {
      lock = {
        raw_lock = {
          lock = 0
        }
      },
      task_list = {
        next = 0x337de307c50,
        prev = 0x337de307c50
      }
    }
  },
  oldstate = {
    rgos_norm = 0,
    rgos_exp = 0
  }
}

Any idea?
