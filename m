Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B07735503D
	for <linux-s390@vger.kernel.org>; Sat,  7 Feb 2026 22:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770502024; cv=pass; b=bYbBYLFVWf4XfILhKM1JJxzefVg6yX++e1sNShxdJaMZCDnYEfTeUg7P+racan+jr7zNxcMQSvPgtARCPq9kY42tpaE4YRq1VIy2S/WKtjfDlWI+4EWCMpr1VqTjLVxBMyB1FaqzxLqf4TqixGxd4XLnn2ns64FXQDy6m+NJRbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770502024; c=relaxed/simple;
	bh=7kTLyrIqEeBYMPXrfcKIpipgbii4dBxT1afSE5hho0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pWBMSnsVVH5UatTD5VzsY81qOmC8S3KW8qMUGoYRtzB9EWGVONHxKBLB7CFjBL2W4mk0JE2dcrmhwTpkoL8BXdxPTm562e0CzoZEnTYPSTmSetxzJNO6aSiVLC9mQBDL9rGFvY22BPh+VjObtaUYZXVagFtEXTobM4mZStaVdw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=02DfaiRy; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="02DfaiRy"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2a76b39587aso59535ad.0
        for <linux-s390@vger.kernel.org>; Sat, 07 Feb 2026 14:07:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770502023; cv=none;
        d=google.com; s=arc-20240605;
        b=jGljm4dJ8oz07k8+IumaruNjc9PAKyWkFIsLpnx2P6bHEmhOG18eW1TsGk3OOlWdJX
         pSEVtX1hQZaN86XkmAROg/4Uf1FUEC68qp6vwf/h559c+ulRrzeVytaO9u/+AxX5U5+z
         EOw7UWv7xme1is5q1AHC7tW5m9PiEil8IJRmTWLou3sF/wxLJPAKZR0D4oKfiq4wWpss
         rL+TXoR+g+FRDUtQw1edMX68zTaHUV+sT4tHtDIl+HvlD0BAcDDVsyziKJemoZtLSUN1
         lOdJhvXeWPh6C2Z6xo164kPgE3DtcTFSe6fl+caC8bn1iFXvgqh80/Ohe1y8VQYsvpZn
         +Ljw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=J3C2hEyl05hEdCU16Qu+GAUyjf5mEA691562VQd1BHo=;
        fh=HrOsuLhw6iOl5JNX86HZ8alVzcgzLnt5Mt78eZm/lO4=;
        b=NTpmnUaaUlU8CwwNVFheq7/YKI/9Eg92D6vRcwuJjE0P9mWVjuiiG2ThPdimfu7pRD
         WRL2i9Y9yAiQaAjSP5s4XIgKZCp1iZjCszVmPxXdd2xPUQ33g9mj54UFnSAfy3KfYYdn
         y50ZFUPyHzvOJYT/h21h5av7bVao4B1ThQtvpmpA3z+0EX6t8LVCuvnE1gFnr/T+KNRi
         ssSNFZ0CdIrODv4hcdOSh3hQmkZYORteafHl8dCv8p4oLNQjj/txHKnZspewbdKoq7Wu
         3hQU9X4PxS2yXbBYTPRwgXhs42gPyDr8kw6vOf+CvUaBS3L4sOdQoqvGXl5iUni6f0Z2
         Behg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770502023; x=1771106823; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J3C2hEyl05hEdCU16Qu+GAUyjf5mEA691562VQd1BHo=;
        b=02DfaiRyWqh1ZnOVxBQhrO3X1GUpQ1tBQq3VzoszXMpdsTLvIRngrL+1Q7JNdNloNq
         bjvTVbCyLiBwrUzZMoqv+AbHectrQKifULJCJOgbZKTSmvcf2C0cCE7uNVqxoKFROB3A
         eo0eiR5tmRbymssjRWtu4M5qtLrP7f1rq9+4HDGJQmKPAxoS5wgrKA1RiWTNJD0Oc65r
         NTrYMH5pU4N5lHOCHbBKfyYMm5tEDw29dmWDzXDfPhFbWY2kqc7Bm/rbsfPoye7kbk+w
         clmU5/dZTEQ4OiC1ZLOqD7zBRdJhhDNNcO2ccxO/tYUKK7PHJ0HT8j3a7onXAe8I8K1x
         dhQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770502023; x=1771106823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J3C2hEyl05hEdCU16Qu+GAUyjf5mEA691562VQd1BHo=;
        b=iEy0aCuwwhmsgkUGS3P52waWtYHFzTnJIzDcDbgCVITyfhCll5PQp6BebQAR0pcexW
         UruLIxxVPwB3ac+2fRF2aZqCze9vI3crq6L3CciOKNWOfxjVmYQF2xeMp+T9McZYytP0
         MTOHuUKezHWj+8EAtmhaFp7upSrPg8oe/ZWrgEV4NECrU+oVbUYA0Gty1ekwHNilgwNs
         AaXbJR78Zbpo980xxOeuFrNOXYuqClSxqUwkc6f8Lpul8kwGJhiF/HNXfhR1lCCPGiIr
         Nz87BIurVy57n/yVGj0tbQ0nqWj+9FBYf8yBjgKj0l5Vm9s6uAegfa6WScK/iOpqFcro
         QjIw==
X-Forwarded-Encrypted: i=1; AJvYcCUplapYEMcw4GfwPQLZZEKwgBOm4mT/7cBxRBiEg0DxQ/riRZXu47qmCPfOlfHloBIOnwMmyRT4D8d8@vger.kernel.org
X-Gm-Message-State: AOJu0YwClvVle5NeS6llweeuMThufhDqdjktYgysNNoJqkx+eIFWFi7V
	W8cVKj4CzaeMXlTqRW7/RyColrey+1UiWOu197AWFHonWpxnrv9SwDytD2skzSh5A2NjUotwGq1
	JRZjHQELkpMBkhs1t4ZZjlacEF+Ducml48tbvCrzB0XBWJZGn0FSFGqEbhCk=
X-Gm-Gg: AZuq6aK5y7scJ7vof7su+r0H0thKTNAo+0kLSjtIqCq1B6v74TH9GdfsgsO7t/YL5q3
	/xgA0bIblu0FYwih0zJHyvlcUQPztrsDOBUYftiDUhhib8CaGKtGUPiU5rdikZgQbFB70pZm9Pw
	RSry7Lyym5M3rVRKj1HL67DRIrU4WHBCDtaORaa0VnrKAM4L9oAEzBzAw2AFBBIqgySi0vHvbIh
	JTlSCJPMERR+l6DePNtNmJoN1y+OVoU7DZyOBsurudNSVPHAZSJPe4AjisGuDtbKfj8kkny
X-Received: by 2002:a17:903:18e:b0:295:3f35:a315 with SMTP id
 d9443c01a7336-2a96317bcf8mr1841385ad.5.1770502023030; Sat, 07 Feb 2026
 14:07:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251128091139.1309755-1-tmricht@linux.ibm.com> <aYZgGlh3e84ZrUNQ@x1>
In-Reply-To: <aYZgGlh3e84ZrUNQ@x1>
From: Ian Rogers <irogers@google.com>
Date: Sat, 7 Feb 2026 14:06:51 -0800
X-Gm-Features: AZwV_Qj4lIuevn1tAZJddgShRS2g2WCpdZDPcsAzuoyzJJJEN9NqPq_JGAkEYIg
Message-ID: <CAP-5=fXJd+gXWrgRC1vBzueCgsLjGesV+oenq3a9irq0+gLNDw@mail.gmail.com>
Subject: Re: [PATCH] perf/test: Fix test case Leader sampling on s390.
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Thomas Richter <tmricht@linux.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	namhyung@kernel.org, agordeev@linux.ibm.com, gor@linux.ibm.com, 
	sumanthk@linux.ibm.com, hca@linux.ibm.com, japo@linux.ibm.com, 
	James Clark <james.clark@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 6, 2026 at 1:41=E2=80=AFPM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> On Fri, Nov 28, 2025 at 10:11:39AM +0100, Thomas Richter wrote:
> > The subtest 'Leader sampling' some time fails on s390.
> > - for z/VM guest: Disable the test for z/VM guest. There is no
> >   CPU Measurement facility to run the test successfully.
> > - for LPAR: Use correct event names.
>
> This one fell thru the cracks, still applies cleanly and the extra logic
> affects only s390, applying to perf-tools-next,
>
> - Arnaldo
>
> > A detailed analysis follows here:
> > Now to the debugging and investigation:
> > 1. With command
> >        perf record -e '{cycles,cycles}:S' -- ....
> >    the first cycles event starts sampling.
> >    On s390 this sets up sampling with a frequency of 4000 Hz.
> >    This translates to hardware sample rate of 1377000 instructions per
> >    micro-second to meet a frequency of 4000 HZ.
> >
> > 2. With first event cycles now sampling into a hardware buffer, an
> >    interrupt is triggered each time a sampling buffer gets full.
> >    The interrupt handler is then invoked and debug output shows the
> >    processing of samples.  The size of one hardware sample is 32 bytes.
> >    With an interrupt triggered when the hardware buffer page of 4KB
> >    gets full, the interrupt handler processes 128 samples.
> >    (This is taken from s390 specific fast debug data gathering)
> >    2025-11-07 14:35:51.977248  000003ffe013cbfa \
> >          perf_event_count_update event->count 0x0 count 0x1502e8
> >    2025-11-07 14:35:51.977248  000003ffe013cbfa \
> >          perf_event_count_update event->count 0x1502e8 count 0x1502e8
> >    2025-11-07 14:35:51.977248  000003ffe013cbfa \
> >          perf_event_count_update event->count 0x2a05d0 count 0x1502e8
> >    2025-11-07 14:35:51.977252  000003ffe013cbfa \
> >          perf_event_count_update event->count 0x3f08b8 count 0x1502e8
> >    2025-11-07 14:35:51.977252  000003ffe013cbfa \
> >          perf_event_count_update event->count 0x540ba0 count 0x1502e8
> >    2025-11-07 14:35:51.977253  000003ffe013cbfa \
> >          perf_event_count_update event->count 0x690e88 count 0x1502e8
> >    2025-11-07 14:35:51.977254  000003ffe013cbfa \
> >          perf_event_count_update event->count 0x7e1170 count 0x1502e8
> >    2025-11-07 14:35:51.977254  000003ffe013cbfa \
> >          perf_event_count_update event->count 0x931458 count 0x1502e8
> >    2025-11-07 14:35:51.977254  000003ffe013cbfa \
> >          perf_event_count_update event->count 0xa81740 count 0x1502e8
> >
> > 3. The value is constantly increasing by the number of instructions
> >    executed to generate a sample entry.  This is the first line of the
> >    pairs of lines. count 0x1502e8 --> 1377000
> >
> >    # perf script | grep 1377000 | wc -l
> >    214
> >    # perf script | wc -l
> >    428
> >    #
> >    That is 428 lines in total, and half of the lines contain value
> >    1377000.
> >
> > 4. The second event cycles is opened against the counting PMU, which
> >    is an independent PMU and is not interrupt driven.  Once enabled it
> >    runs in the background and keeps running, incrementing silently
> >    about 400+ counters. The counter values are read via assembly
> >    instructions.
> >
> >    This second counter PMU's read call back function is called when the
> >    interrupt handler of the sampling facility processes each sample. Th=
e
> >    function call sequence is:
> >
> >    perf_event_overflow()
> >    +--> __perf_event_overflow()
> >         +--> __perf_event_output()
> >                +--> perf_output_sample()
> >                     +--> perf_output_read()
> >                          +--> perf_output_read_group()
> >                                 for_each_sibling_event(sub, leader) {
> >               values[n++] =3D perf_event_count(sub, self);
> >               printk("%s sub %p values %#lx\n", __func__, sub, values[n=
-1]);
> >                                 }
> >
> >    The last function perf_event_count() is invoked on the second event
> >    cylces *on* the counting PMU. An added printk statement shows the
> >    following lines in the dmesg output:
> >
> >    # dmesg|grep perf_output_read_group |head -10
> >    [  332.368620] perf_output_read_group sub 00000000d80b7c1f values 0x=
3a80917 (1)
> >    [  332.368624] perf_output_read_group sub 00000000d80b7c1f values 0x=
3a86c7f (2)
> >    [  332.368627] perf_output_read_group sub 00000000d80b7c1f values 0x=
3a89c15 (3)
> >    [  332.368629] perf_output_read_group sub 00000000d80b7c1f values 0x=
3a8c895 (4)
> >    [  332.368631] perf_output_read_group sub 00000000d80b7c1f values 0x=
3a8f569 (5)
> >    [  332.368633] perf_output_read_group sub 00000000d80b7c1f values 0x=
3a9204b
> >    [  332.368635] perf_output_read_group sub 00000000d80b7c1f values 0x=
3a94790
> >    [  332.368637] perf_output_read_group sub 00000000d80b7c1f values 0x=
3a9704b
> >    [  332.368638] perf_output_read_group sub 00000000d80b7c1f values 0x=
3a99888
> >    #
> >
> >    This correlates with the output of
> >    # perf report -D | grep 'id 00000000000000'|head -10
> >    ..... id 0000000000000006, value 00000000001502e8, lost 0
> >    ..... id 000000000000000e, value 0000000003a80917, lost 0 --> line (=
1) above
> >    ..... id 0000000000000006, value 00000000002a05d0, lost 0
> >    ..... id 000000000000000e, value 0000000003a86c7f, lost 0 --> line (=
2) above
> >    ..... id 0000000000000006, value 00000000003f08b8, lost 0
> >    ..... id 000000000000000e, value 0000000003a89c15, lost 0 --> line (=
3) above
> >    ..... id 0000000000000006, value 0000000000540ba0, lost 0
> >    ..... id 000000000000000e, value 0000000003a8c895, lost 0 --> line (=
4) above
> >    ..... id 0000000000000006, value 0000000000690e88, lost 0
> >    ..... id 000000000000000e, value 0000000003a8f569, lost 0 --> line (=
5) above
> >
> > Summary:
> > - Above command starts the CPU sampling facility, with runs interrupt
> >   driven when a 4KB page is full. An interrupt processes the 128 sample=
s
> >   and calls eventually perf_output_read_group() for each sample to save=
 it
> >   in the event's ring buffer.
> >
> > - At that time the CPU counting facility is invoked to read the value o=
f
> >   the event cycles. This value is saved as the second value in the
> >   sample_read structure.
> >
> > - The first and odd lines in the perf script output displays the period
> >   value between 2 samples being created by hardware. It is the number
> >   of instructions executes before the hardware writes a sample.
> >
> > - The second and even lines in the perf script output displays the numb=
er
> >   of CPU cycles needed to process each sample and save it in the event'=
s
> >   ring buffer.
> > These 2 different values can never be identical on s390.
> >
> > Since event leader sampling is not possible on s390 the perf tool will
> > return EOPNOTSUPP soon. Perpare the test case for that.
> >
> > Suggested-by: James Clark <james.clark@linaro.org>
> > Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> > Tested-by: Jan Polensky <japo@linux.ibm.com>
> > Reviewed-by: Jan Polensky <japo@linux.ibm.com>
> > ---
> >  tools/perf/tests/shell/record.sh | 16 +++++++++++++++-
> >  1 file changed, 15 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/=
record.sh
> > index 0f5841c479e7..46b96d565680 100755
> > --- a/tools/perf/tests/shell/record.sh
> > +++ b/tools/perf/tests/shell/record.sh
> > @@ -260,7 +260,21 @@ test_uid() {
> >
> >  test_leader_sampling() {
> >    echo "Basic leader sampling test"
> > -  if ! perf record -o "${perfdata}" -e "{cycles,cycles}:Su" -- \
> > +  events=3D"{cycles,cycles}:Su"
> > +  [ $(uname -m) =3D "s390x" ] && {

This broke shell check for me:
```
In tests/shell/record.sh line 264:
 [ $(uname -m) =3D "s390x" ] && {
   ^---------^ SC2046 (warning): Quote this to prevent word splitting.

For more information:
 https://www.shellcheck.net/wiki/SC2046 -- Quote this to prevent word split=
t...
```

I'll mail the fix.

Thanks,
Ian

> > +    [ ! -d /sys/devices/cpum_sf ] && {
> > +      echo "No CPUMF [Skipped record]"
> > +      return
> > +    }
> > +    events=3D"{cpum_sf/SF_CYCLES_BASIC/,cycles}:Su"
> > +    perf record -o "${perfdata}" -e "$events" -- perf test -w brstack =
2> /dev/null
> > +    # Perf grouping might be unsupported, depends on version.
> > +    [ "$?" -ne 0 ] && {
> > +      echo "Grouping not support [Skipped record]"
> > +      return
> > +    }
> > +  }
> > +  if ! perf record -o "${perfdata}" -e "$events" -- \
> >      perf test -w brstack 2> /dev/null
> >    then
> >      echo "Leader sampling [Failed record]"
> > --
> > 2.52.0
>
