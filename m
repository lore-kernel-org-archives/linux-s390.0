Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XToJ42kY"
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF54120
	for <linux-s390@vger.kernel.org>; Wed, 29 Nov 2023 01:20:09 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-67a44ee7ab3so19657556d6.0
        for <linux-s390@vger.kernel.org>; Wed, 29 Nov 2023 01:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701249608; x=1701854408; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q6jgX+fdtw/9pVukVvzlC00W/od07a5izGjIu/hs4qE=;
        b=XToJ42kYKxo9SJQeysuJw7T93iaB5H7pjuRFx9qFaPChG//ulhnvlopmgkdORtWyk/
         diiXCKJ/nzMHh1ljQTTbGx1aSf1T9kJNNANOgNeHhpEpbqQAdTHWFskLMv/OtBKwfWb/
         IffMjHq4RLsr1rnkBk9p6reCiukLr/wZKWAfcIyZmjHPg2BJZhvEf7Jim58/w291dLaR
         jSFhOz82tdRL3h5Ne7W1xrM/MwBT5erbBKZwpK9aTHzmW1X1DWS7urZROV2gnWeqnnhq
         m3aPOG214rsMR3wknEqtO3/qPloB4WtPkJgD7AyqlnkK0HpeamFlE9GWqizF8oBjeUb4
         Jb8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701249608; x=1701854408;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q6jgX+fdtw/9pVukVvzlC00W/od07a5izGjIu/hs4qE=;
        b=HK84cjaoPXUde8LG7UBqJasbfjLErx4Bj0nz9F9TEX59IS+2K1PPFh+HY9n2VBcS4g
         MBgzRkJGV2X5NHPYzbhseAa+jp+v392oKokUhoGPrGTvHd8iPUylhz0412CjsgGBgoAy
         vw78AdeAkWOL1pqXYr4RCFsqX68eQZDV0bOpaW87HB1UuRBHhB3kkiU2qok72aKhwEEF
         tVFeYr/xCLWA80Z6eRZOevpWcmj+8GMcC8/CFbet11nkG14/pq3SpXFN3SK7l+6SIqVo
         9CAM5EYhb/XNcTRLwFeRggqJGZ1y1rvyN+T6xxYQeu7XPVPOYrRApsWEuxjofD1+JfBS
         bMUQ==
X-Gm-Message-State: AOJu0Yw0dpsplEUqsSp8DmO6GlYOPAei17Ju/EOSd5nCSvfl10DstjHg
	uSbbF3qHpggGKDrrbipMI/XacLk2Ktwyk6vnCaD9xg==
X-Google-Smtp-Source: AGHT+IHqiXE0zJisfc2kGLRsSrhk09nD6kqfJtIYT5sewkmbb0V0LnYF/lh61UmHuguBtkr3GCLsTIMLQyCS24iqQho=
X-Received: by 2002:a0c:fccc:0:b0:67a:492b:6cbd with SMTP id
 i12-20020a0cfccc000000b0067a492b6cbdmr8165414qvq.6.1701249608288; Wed, 29 Nov
 2023 01:20:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231121220155.1217090-1-iii@linux.ibm.com> <20231121220155.1217090-34-iii@linux.ibm.com>
In-Reply-To: <20231121220155.1217090-34-iii@linux.ibm.com>
From: Alexander Potapenko <glider@google.com>
Date: Wed, 29 Nov 2023 10:19:29 +0100
Message-ID: <CAG_fn=XCeE7JF5hbpzXu2A0Cae3R16_hnDwF0==oJMX320wBHQ@mail.gmail.com>
Subject: Re: [PATCH v2 33/33] kmsan: Enable on s390
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Marco Elver <elver@google.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Pekka Enberg <penberg@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Vasily Gorbik <gor@linux.ibm.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-s390@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Sven Schnelle <svens@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

Hi Ilya,

Sorry for this taking so long, I'll probably take a closer look next week.
Overall, the s390 part looks good to me, but I wanted to check the x86
behavior once again (and perhaps figure out how to avoid introducing
another way to disable KMSAN).
Do you happen to have a Git repo with your patches somewhere?
