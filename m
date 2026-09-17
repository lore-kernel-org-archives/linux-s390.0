Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154E83812F6;
	Thu, 17 Sep 2026 05:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789624586; cv=none; b=pNh65hvcceXssJ+MNte2ogsAfoBAjGhSI5wtU5mZyhAYFfwimHjqJMqgPKjInPqBEIeS8TOn6cxrgqG/wPRmw5KnOHtd4+pEDFDm8DLRs6DNnCqwhDQ4RM6PdJWjXaugKK5IptBMYo8/6Fo2DlEFLA9OaQGepG0jUydWb6PABVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789624586; c=relaxed/simple;
	bh=Mbwi+hAEJ2TOuE5pCiU68p6QpU+CXNObLTPMmeKgryc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=IgML+dkT5c5Rt/8s51jUv/A/ov/QBG8mC/dXiRmCJGzMwr8lU7LU0gnfdfmhuASIuUi0EYhvbOpKaTyrm1yZhz8DSQj3hLN9rKCxOPpaFSbKTWXxVYLxG0wEfoM6E1IiWz75FxZWuMjNTeJoD+8y7GCOntIf/4jg8g8NaEuiQSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=GGbp4G/u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eBKaRa1q; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="GGbp4G/u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eBKaRa1q"
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfout.phl.internal (Postfix) with ESMTP id 05937EC0118;
	Thu, 17 Sep 2026 01:56:21 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Thu, 17 Sep 2026 01:56:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1789624581;
	 x=1789710981; bh=E6Vg3bpUqSz3Pj9xg3oQSweER3Z7QxD7M1oDqjqbTDE=; b=
	GGbp4G/u+roLCBBW1X5LxaPuo76yNpQDClMQMHkJmJCuirPtxMNGj1jajS/PTGfN
	JVK1YQbrVgyHcM5r88NM4U1E5do7xAG78NOL+9CDBRjuk4KEDE8BSVNmyWM2arDJ
	ra6+Btxidwe4vTBDTMhblROGwZLbytUpIx8EtmlM6yA6jtQGaTqKRX4Dcxb4n3au
	NnEUSdf3EDdHJlXkS0zp+WeWiCdYUBSaP3a2dk6oKO2VhmXUl2wKRWIPoO0ogHee
	CTESVdKNA7pcf9Jyz9Bi4fAR7ZK+I+rZuCxYMynFJmHpCV8DV2WexIiE75gl9N76
	+rV/p9tZhFNfaPbak9I0QQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789624581; x=
	1789710981; bh=E6Vg3bpUqSz3Pj9xg3oQSweER3Z7QxD7M1oDqjqbTDE=; b=e
	BKaRa1qijVXP/ajZuMAbyukMZKAFqJbMTTD1l4SzixYv2o9ux9k5SpwWP6shuZi6
	865rELRDQkGVQ560bbGAEs54IVn96qd4TZC64dVV29s6tGRKoIBB1oCprIIIaEBd
	R0a7/WhCklnf2k3mcDGVJbRtWfJVKB5iZwosgZAiPT+EpCM7CHbR1Vy+4iS8wX36
	9LE9fv8WA5KCuoK1eq0iy9Nvfsm/+T+u996e9rpT3cllfrv7U3tMxNRiMsRo48MS
	Gs8UoeIwlWQsI4PPWOdU3eoVd3Kcq8wnnb8EGn6UcR8ip06o0H13XQAPCaNsXY8a
	SC8VoEXEyTHTEalfPb/FA==
X-ME-Sender: <xms:AIGranrIsNzd-n5_Y_lgDm8e4SveGD4WDkkQG1exaPyHNwyfIvTZbA>
    <xme:AIGrasfLaUOrMTpyOBaiZ89PwG8J6Edhypf-kwZqr_K80-fhGBuGj5T1N5bvggTAM
    hNpTkii2-BASlIC_B0jMI20PaaeEPo5rxYuOFCVD9hYmZKqVFtADLNk>
X-ME-Proxy-Cause: dmFkZTFlx2cT7GLNvlNJEzNcY+Amz1Ciq+yjddF3pMcq3/zZLoLLD2H82cYq+2SeOYQV9f
    vehC8tp9xFp5qadWLjh+qiCAyw47Ch69MWx66qZr1l/WAmg0WrvOpJumDcq+uMYLgMnaui
    vaVxLdO2W1cWqVPF2UQHOQ36xm/wSftcKi+Ca//GEsMgqK0MrQF4x4me01uH4IRb68jYyZ
    OJUk4XkunCR4+ds+tTViycw2avGqXhI22CM1Gdy9ZkMp0uMjDt0GHh5BtN/7tM6ztMugOO
    92nCc5FFXjf//UTJ5Y2mBwu5H/nqaISdKHJ3PiRgUtwGCanRvVJS3KCcsANToDdrbd1uIU
    UB3LfmT1/5WcpFhho/ss8YDyEuTq93o6YW96Fvy/GopTRZ6mFe/jVCl8NbTSToGxqkDZbs
    ae8Ec1jmx/4fmaS8R2dq6A2nJe2Bu44omcwh+Uc9+lks0BIAHWfdBfCpP3a9aU9ElZQ42V
    tzgYuvZzo4kLrFFQuxbRatLhcsKUYLu2bsEuApzGxJOJcwFxJT6tGlg7ICwRL9cxg2d27W
    PEw7JxMlTUJXiJY/M9hMFCSD+ao51qh4AO9SuMAYNv1dFuqTFP0fTJGZ9uIE1md1Gcy6sP
    Gu4Im/oJu2smgsG47SdCFaov6IfT7eJU7LO6HoFrSlZ85HOX4lBZdHSlbcXw
X-ME-Proxy: <xmx:A4GraqsT-7Y_-7Pi_lEQa9ygymHWBMqAV-q_z0fAlD7Xl_MrRPlTuw>
    <xmx:A4Grav504RveMCKeSbDWGAtYZXxblOBcBDM643TN_YWDjAcwkhNOLA>
    <xmx:A4Gralh0Ju2t_GxhEHoVaLRYJnMALJOoo5IhfOlSiHGY4nVCRFoeaw>
    <xmx:A4GrahlpmG0IUBEpT0yA3bHiuuRcQz4vCKr1JaFc3Ko2r-rZJiVgpw>
    <xmx:BYGrat3f9YzO4JP-AGGLy-4_Rp9eLrex7DBQngPe_b2S_5s8Oivy7jAX>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id A4D9532A0084; Thu, 17 Sep 2026 01:56:16 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AA0MNwphKERR
Date: Thu, 17 Sep 2026 07:55:56 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: "Christian Brauner" <brauner@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, kernel-dev@igalia.com,
 "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
 linux-alpha@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, soc@lists.linux.dev,
 linux-mips@vger.kernel.org, sparclinux@vger.kernel.org
Message-Id: <5aedf90f-d30d-4f55-b066-dd8fdf3ff8f9@app.fastmail.com>
In-Reply-To: <6fa4e1e3-c023-465c-9490-ce2f18ffaa91@igalia.com>
References: <20260828-tonyk-syscall_table-v6-0-fdd358456cf1@igalia.com>
 <95b693c0-ca51-4355-99ba-2b37a1ab2169@app.fastmail.com>
 <6fa4e1e3-c023-465c-9490-ce2f18ffaa91@igalia.com>
Subject: Re: [PATCH v6 00/13] syscalls: Add a shared table for all archs
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026, at 00:19, Andr=C3=A9 Almeida wrote:
> Em 15/09/2026 04:45, Arnd Bergmann escreveu:
>> On Sat, Aug 29, 2026, at 01:19, Andr=C3=A9 Almeida wrote:
>
> Thanks for testing! I believe I found a simple solution for this. I=20
> modified syscall_o32.tbl and can confirm it triggers a rebuild now:
>
> diff --git a/arch/mips/kernel/syscalls/Makefile=20
> b/arch/mips/kernel/syscalls/Makefile
> index aaa5443ea906..9e31d1ce5015 100644
> --- a/arch/mips/kernel/syscalls/Makefile
> +++ b/arch/mips/kernel/syscalls/Makefile
> @@ -40,10 +40,10 @@ src_n32 :=3D $(src)/syscall_n.tbl
>   src_n64 :=3D $(src)/syscall_n.tbl
>   src_o32 :=3D $(src)/syscall_o32.tbl
>
> -$(kapi)/unistd_nr_%.h: $(systbl_common) $(sysnr) FORCE
> +$(kapi)/unistd_nr_%.h: $(systbl_common) $(src_%) $(sysnr) FORCE
>          $(call if_changed,sysnr)
>
> -$(kapi)/syscall_table_%.h: $(systbl) $(systbl_common) FORCE
> +$(kapi)/syscall_table_%.h: $(systbl) $(systbl_common) $(src_%) FORCE
>          $(call if_changed,systbl)

I had tried the same thing already, but in my testing, it did
not rebuild after changing the syscall_n.tbl file, only the=20
syscall_o32.tbl file. Can you verify that your change rebuilds
all nine files in the correct cases?

>> The rt_sigtimedwait and ustat entries had a typo that caused a link
>> error, but I did not check if there were any additional mistakes that
>> caused incorrect output data without causing a link failure.
>>=20
>
> Ops, my bad. I had another round comparing the tables, and I found=20
> another case that needed a fix:
>
> diff --git a/arch/mips/kernel/syscalls/syscall_n.tbl=20
> b/arch/mips/kernel/syscalls/syscall_n.tbl
> index e3d278f715b7..1882527053af 100644
> --- a/arch/mips/kernel/syscalls/syscall_n.tbl
> +++ b/arch/mips/kernel/syscalls/syscall_n.tbl
> @@ -43,7 +43,7 @@
>   33     common  pause                           sys_pause
>   34     common  nanosleep                       sys_nanosleep=20
> sys_nanosleep_time32
>   35     common  getitimer                       sys_getitimer=20
> compat_sys_getitimer
> -36     common  setitimer                       sys_setitimer=20
> compat_setitimer
> +36     common  setitimer                       sys_setitimer=20
> compat_sys_setitimer
>   37     common  alarm                           sys_alarm
>   38     common  getpid                          sys_getpid
>   39     common  sendfile                        sys_sendfile64=20
> compat_sys_sendfile

Looks good, thanks for checking this one.

    Arnd
