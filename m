Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E7B8C433FE
	for <linux-s390@archiver.kernel.org>; Thu, 27 Jan 2022 10:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239511AbiA0Kc5 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 27 Jan 2022 05:32:57 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38656 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239505AbiA0Kc4 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 27 Jan 2022 05:32:56 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20R9fjiO017398;
        Thu, 27 Jan 2022 10:32:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=qlg2GBduxp6GIl9IBt5bg67yncbbbKAJWeuTOq+D38w=;
 b=Yg5IKpspuINer+7KoO7TTNRaV4MXzEN2l6XK7F0O7cZQLOnFphce1znToSTmLIdO79h0
 IY2nqNZSwqXnhMdJnAp2LdqXAAuiXJQEYjnVyh0zTIiBqu960otSlt4NDq3DRfE5uJyf
 igrzCAG7Nd1wwJKzl19pHVhP0azGn4OaoJL4Do81NZEhICJsxZLjRnr2wxjM6lTnIEzp
 Ayu5u/GoagGnaGDJzaClx1EEKSiBdU6SWUkBmElwKzTvztitLZPya7qna/fuhisijPLg
 8J/pcnt7lL2NofiihbTC42ylnpzb4eGxaCIYMccNX6BhzV/Cz/zkasULWkwu/CJvF1s7 Zw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dus019406-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jan 2022 10:32:45 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20RAQcCP025080;
        Thu, 27 Jan 2022 10:32:45 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dus0193x3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jan 2022 10:32:45 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20RASQ9A016214;
        Thu, 27 Jan 2022 10:32:42 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3dr9j9pad4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jan 2022 10:32:42 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20RAWep537093796
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jan 2022 10:32:40 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 595D9AE0CE;
        Thu, 27 Jan 2022 10:32:40 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E8073AE0B3;
        Thu, 27 Jan 2022 10:32:39 +0000 (GMT)
Received: from [9.145.35.183] (unknown [9.145.35.183])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 27 Jan 2022 10:32:39 +0000 (GMT)
Message-ID: <a90563ea-2740-d4ca-d2f3-6b6861faf0de@linux.ibm.com>
Date:   Thu, 27 Jan 2022 11:32:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH qemu v2] s390x: sck: load into a temporary not into in1
Content-Language: en-US
To:     Nico Boehr <nrb@linux.ibm.com>, qemu-devel@nongnu.org
Cc:     linux-s390@vger.kernel.org, thuth@redhat.com,
        richard.henderson@linaro.org, david@redhat.com
References: <20220126084201.774457-1-nrb@linux.ibm.com>
From:   Janosch Frank <frankja@linux.ibm.com>
In-Reply-To: <20220126084201.774457-1-nrb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VioI6M4vsHeBowhx7xV_BYlt2HDQJU16
X-Proofpoint-ORIG-GUID: gh6LpCXGAdak8xr3cCdrFPmwvQX9gwTJ
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-27_02,2022-01-27_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 impostorscore=0 priorityscore=1501
 phishscore=0 adultscore=0 clxscore=1015 mlxscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201270063
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 1/26/22 09:42, Nico Boehr wrote:
> We previously loaded into in1, but in1 is not filled during
> disassembly and hence always zero. This leads to an assertion failure:
> 
>    qemu-system-s390x: /home/nrb/qemu/include/tcg/tcg.h:654: temp_idx:
>    Assertion `n >= 0 && n < tcg_ctx->nb_temps' failed.`
> 
> Instead, use in2_la2_m64a to load from storage into in2 and pass that to
> the helper, which matches what we already do for SCKC.
> 
> This fixes the SCK test I sent here under TCG:
> <https://www.spinics.net/lists/kvm/msg265169.html>
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Nico Boehr <nrb@linux.ibm.com>

@David: Was this already broken when it was implemented?
I.e. do we want a "Fixes: 9dc67537 ("s390x/tcg: implement SET CLOCK ")" tag?


> ---
>   target/s390x/tcg/insn-data.def | 2 +-
>   target/s390x/tcg/translate.c   | 3 +--
>   2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/target/s390x/tcg/insn-data.def b/target/s390x/tcg/insn-data.def
> index 3e5594210c88..848a9c9e622f 100644
> --- a/target/s390x/tcg/insn-data.def
> +++ b/target/s390x/tcg/insn-data.def
> @@ -1317,7 +1317,7 @@
>   /* SET ADDRESS SPACE CONTROL FAST */
>       F(0xb279, SACF,    S,     Z,   0, a2, 0, 0, sacf, 0, IF_PRIV)
>   /* SET CLOCK */
> -    F(0xb204, SCK,     S,     Z,   la2, 0, 0, 0, sck, 0, IF_PRIV | IF_IO)
> +    F(0xb204, SCK,     S,     Z,   0, m2_64a, 0, 0, sck, 0, IF_PRIV | IF_IO)
>   /* SET CLOCK COMPARATOR */
>       F(0xb206, SCKC,    S,     Z,   0, m2_64a, 0, 0, sckc, 0, IF_PRIV | IF_IO)
>   /* SET CLOCK PROGRAMMABLE FIELD */
> diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
> index dcc249a197ce..7fb87cd9f3b7 100644
> --- a/target/s390x/tcg/translate.c
> +++ b/target/s390x/tcg/translate.c
> @@ -4295,8 +4295,7 @@ static DisasJumpType op_stcke(DisasContext *s, DisasOps *o)
>   #ifndef CONFIG_USER_ONLY
>   static DisasJumpType op_sck(DisasContext *s, DisasOps *o)
>   {
> -    tcg_gen_qemu_ld_i64(o->in1, o->addr1, get_mem_index(s), MO_TEQ | MO_ALIGN);
> -    gen_helper_sck(cc_op, cpu_env, o->in1);
> +    gen_helper_sck(cc_op, cpu_env, o->in2);
>       set_cc_static(s);
>       return DISAS_NEXT;
>   }
> 

