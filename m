Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="H75y2WMc"
Received: from sonic306-22.consmr.mail.ne1.yahoo.com (sonic306-22.consmr.mail.ne1.yahoo.com [66.163.189.84])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFBD5133
	for <linux-s390@vger.kernel.org>; Sat, 25 Nov 2023 16:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1700957254; bh=VOkfTpOmq17D1dSJ+Jm/40t0YEg9kmf39h8y5d76ulg=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=H75y2WMcuwE92zd4N89muiHtpEdiKyI7LUUmiyyRWXjKZcWcogIFtF0daOxNgZ1Xd98lDAop7FOnLdoEWbJ3GC21lQUl3LYPPJyjrrQeWEs+aKeDVt+nHf3IsKbbOgUdNJpqCWFHqPMflYvdpzZ/oxb78EIY3Hlek4E8Qc1Z4DnJx5sR802ue2sZ1eUBLx/u71GApXcgJtPnpg2+r76ruINwsw8OwgvZbHNU7TyrpKUK3Ow/ZDhejHJ+9nJvtinh2cMtXG3Z8SHDvv5hmCeR2PZfKZy5lsD8z9YaBKZWxrvnBks2ynm7AdsUmN8PtdVL2lh2Obx0pXJIlFFd0e70wQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1700957254; bh=obGfrgAMlmRv4h6ywM3ev7exycNZAfh0opSu0pk9QiX=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=MDeAajrJSuW819v2eRlt/X7UkG3tJSIgjGjHXg2pEpVKozEAD7W+4BFjqQa/A7DbKgelMj35YlCauZ11mSkbRjtAiSj+Eln9alOwpW4ajywZ/8kzKqNlN6ldo3efw2m6PLg5wTSs5KZCc+7bKP4BsJlYvlejOQvnSQ/8IMne2oALZj+TkeoxOjniUXCYD+VxOkI6i/ob0IYsDjXNWnHA4aLbzSComM05AKqihXKNnX+Cds7IlBPFX7V3zRzpb7/vfFoPs5eE6hc1o0pLaX/iqGcrb48G6fQZO593Qn0GQRPDDK7rsNJOTzpWBgAyj7lU8xWy0WmquP/3Bkc7u+ACkg==
X-YMail-OSG: R20dOCsVM1nj2FsYcnJkU1x2XJ1s0Q04jmjXXQatqjvhdah5S8F6M2Lz7_qXSX2
 OPEvLJ5hwPCe1hLuOIBu7nkQ70M1MnFNh7zgi._3d6lY7.I_YseEwLR4lknqZ6pBc1qluF_qmuzg
 VKfoBQ6UCM_EUwUe5jIiwtXLn8Ppk_rDKFjr5mqiwUj7utE.sEK.3putvNylPUJBLe_oHe1Kx6Gx
 3aaGa1wwWd2Z0uRWCmI_Q.E0pSzlPoPHu7B0c4nvlu99EzBeAvMyDqJ.ine9M3C3DHU3CZkc_vHJ
 pP0CUg4bFfQZDwXJP5ucXNc4MNfFPC7i9QJLKgyRRXZu9.9JrfcgO5RYGbI.8iggdkHbdRCKm28.
 lXLBRBLYnlcWHkyJxlF2bwhauzMXQZLMEpxNW8u9ZWdbQ6etqbN3chxrLq36j3QHu3cW2MjgbWRH
 t8pIt.VabXomBSTSop.dIMla.9yJw.z5xf4RwFzG4Nbt4FTEeyqXxaHWvaXOcNtY8WXV.yvEGes6
 vQfY_dyf1tljuElFiQEdiOPtDreIYw1Jgh2ZapjWjYCtMNY.YPfCnv3wOlW_rcqd4GBusxR6sP9U
 j_YoT2DG0Y_FhC_vyvTumPpuB64dR0_hb3t9VAavilWmEhqlTtnkys6.JiHPJoTRcPLLSZd7lqbl
 4ZkdtWGo77u.3oOMk_A31aj45S0PCEyLt7yD_fICF_qaq8DqnuxxmKBZIiQlp8BJLiH68zMZ9YBv
 G8qRbnJ4EO5c759S4lFLMle402IYlqDJy_8floFPFTlUuULWYY4fXhrRQtjelwKjzumYf85ljY42
 dGcFheIymaFTUDHlJkcs.kBXEft6Y.x7i5sqEm55nIzk_ZwoK.9AsKxqkw1S.5BI6_tOiqEazRme
 4A9L.pWNM4E0t8wdlKdftWRM8DFshrNKHcmYR4XA8VnCdOkvDV.7jAIqAYC8IrY4Yjrnch8aq1mF
 WFQjBw2ydpCDVPKKFG5oP7Yt2f7p6Y_qU5_8Q1jsSMsDVksw1SmE2DwHFHICJPnz.ATPHVFGLLYv
 9sipqExspUYcFiSbnZj3acUJOxIKll.gIhnN84K0Cr4QYzEz.AITMxbwVxOiPCuZK6G4Zkrw05MI
 LVjkBstdwyM_MRZee38zV.8oqLOcogVjfptFxCcgKkXJrYD9XW1fhHKLY3wIpP6BuuUHKh4WBiKI
 hIK.Yi9hJh3a98iA_JZBMNCd3bfRGyypdqj5Te7K2gFLx51l6GnL1kT4asU8PtMx8bjKcqijEid6
 h93eYMhsd16GZmqSm7WDDOfdW9K4aFe0VvB7qmV9OoIqohiHczaLX5lZEkATrFzbtriczaRWwi5_
 6z0JDfE9qPoETKf6jRTp7WAvOs25hBWfc4eNfA..nndzXg35z46gNyX4GWI1OtNiBgs5PNBEjlSu
 FJrTfcHBFrToA46reuXSFgvB6mefqAHvJ.jooguLuqYPu2mJeT3IQt8bxPGSQpTZYCklo2KNR.m5
 SWN4NFlE7SY5Wo0SYlWI5d8a7rIsPoc.LRruVcMh9BTyI9Y9jxYsvNlPNp6P5vg_GiHaOqYdU6vq
 kyEb8IK5FevHGmED6ONA4fqb1D6gxWBABds91YpipBy.dOa4MHkze6yLerV4N0k4OzJudkROCZeE
 36P4gSrWQVCingXRncF7o8jy.M.Dnk8r0jqj_W7rsVWa.0fNhgehsitAEUrd5hE6X3O3SxPPUeMZ
 Bz4KqsbKrUnoZwvS.3PIsDECzeWvADZpRAZafa77PKDw0BUIBy6p.6SUkudDkdXogaooFY6hdNtk
 eYWZmXFMdZwZvJUhODSz.hf9rg_N_pbMmPs3j.qcO2sehiHkgh9AkQx3gP0mwGB90sXu55qrvfTw
 xFSxAjsIeJyLCJA8xqZfvNfu7OO..i1Yo4s5.z3gvtbhQ8xJlwjXwgt0j2SRSi8TkNUNSPW.ZY71
 teiFewVyKjuukWJNBIa7afcJn0gq0btbqZuDxqIDVknpppa3KHOGxX7BzWNb9E2itEoruJzEf4Hn
 rImYPvyDvR1YPdyw65f.csC.1AbY_QslZmIWKVyecmFrIJBlHr5Rq084l3GXsy43mD9B98B5rmOQ
 sQi95qH.5X5vA0eQSI91GliiJM67lwzKtiJMCnsDQQnAHaycIByyqL8LzHTZ4jHEKqkkQurkb7kC
 0mUdpCgYMwuJncFznHHU.klVXX97WZn0.iFtu2yKV2n6QH4btPQktli1ZMEiCoJqIHsFcdLM1pXs
 7rNz7eYN9sW3fFTY7pXiMQdimJmR4kpwjJZ91hZzRTNaOL32ZOx1eAGH4V7vwmGObWddkCLtFsEt
 PbyAM0w--
X-Sonic-MF: <eric_devolder@yahoo.com>
X-Sonic-ID: cdb36c69-f708-446d-9126-27534636572e
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Sun, 26 Nov 2023 00:07:34 +0000
Received: by hermes--production-bf1-5f77bdbcd8-5xzjb (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID dd8da3a747f8cbf8b17a5db131ed2f58;
          Sun, 26 Nov 2023 00:07:31 +0000 (UTC)
Message-ID: <5ab45f48-9ec2-4611-81a2-4dc2f1854c4f@yahoo.com>
Date: Sat, 25 Nov 2023 18:07:29 -0600
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] kernel/Kconfig.kexec: drop select of KEXEC for
 CRASH_DUMP
Content-Language: en-US
To: Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-s390@vger.kernel.org, akpm@linux-foundation.org, ignat@cloudflare.com
References: <20231123073652.507034-1-bhe@redhat.com>
From: Eric DeVolder <eric_devolder@yahoo.com>
In-Reply-To: <20231123073652.507034-1-bhe@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21896 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo


On 11/23/23 01:36, Baoquan He wrote:
> Ignat reported a potential config regression was introduced by
> commit 89cde455915f ("kexec: consolidate kexec and crash options
> into kernel/Kconfig.kexec"). Please click below link for more details:
>
> https://lore.kernel.org/all/CALrw=nHpRQQaQTP_jZfREgrQEMpS8jBF8JQCv4ygqXycE-StaA@mail.gmail.com/T/#u
>
> The patch 1 fix the regression by removing incorrect CONFIG_KEXEC
> ifdeffery scope adding in arm's <asm/kexec.h>, then dropping the
> select of KEXEC for CRASH_DUMP. This is tested and passed a cross
> comiping of arm.
>
> Patch 2 is to fix a build failure when I tested patch 1 on x86_64, the
> wrong CONFIG_KEXEC iddeffery is replaced with CONFIG_KEXEC_CORE. Test
> passed on x86_64.
>
> Patch 3 is to fix an unnecessary 'select KEXEC' in s390 ARCH. Removing
> the select won't impact anything. Test passed on a ibm-z system.

I apologize for my delay in responding, I did not have a computer with 
me during my holiday travel.

I was able to re-run my Kconfig test script with this patch series (now 
that I'm running this on private resources, it takes half a day 8( ). 
The script only performs comparisons of the .config before (LHSB) and 
after (RHSB) the patch series; it does NOT do any building. At any rate, 
what that revealed was only differences in s390. That means that all 
other arches do not have any unintended side effects. The differences 
with patch3 applied look like:

FAIL: allnoconfig arch/s390/configs/kasan.config
LHSB {'CONFIG_CRASH_CORE': 'y', 'CONFIG_KEXEC_CORE': 'y', 
'CONFIG_KEXEC': 'y'}
RHSB {'CONFIG_KEXEC': 'n'}

The 'allnoconfig' and 'olddefconfig' targets failed for all s390 
defconfigs. The LHSB is the pre-patch values, and the RHSB is the 
post-patch values. So this states that CRASH_CORE and KEXEC_CORE were 
set previously, but now they are not. KEXEC obviously is being turned 
off intentionally.

Hope this helps some.

Regards,

eric



> Baoquan He (3):
>    kernel/Kconfig.kexec: drop select of KEXEC for CRASH_DUMP
>    drivers/base/cpu: crash data showing should depends on KEXEC_CORE
>    s390/Kconfig: drop select of KEXEC
>
>   arch/arm/include/asm/kexec.h | 4 ----
>   arch/s390/Kconfig            | 1 -
>   drivers/base/cpu.c           | 6 +++---
>   kernel/Kconfig.kexec         | 1 -
>   4 files changed, 3 insertions(+), 9 deletions(-)
>
