Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iqle0iK7"
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F151987
	for <linux-s390@vger.kernel.org>; Fri,  8 Dec 2023 08:32:03 -0800 (PST)
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-58d06bfadf8so1133019eaf.1
        for <linux-s390@vger.kernel.org>; Fri, 08 Dec 2023 08:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702053122; x=1702657922; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8sqOsISr4A6CIOB02HqyYbsWnQIUDQQ0cX4xtpbDCng=;
        b=iqle0iK70r7pqT5OYWAQCgwCHN3//A3JOwSyNlG6jMe6rI7p7VsXp6tnD0okNWhfyG
         GDS5nDkyqmttX2Y1P5eH5DJ9LTF97mgtFYvt/KAYfRF79WfHg0XeiRxoe6gGf63VSmb9
         4+cvdtKhHAJC9m7q/XPZg0wwm8Y0UztbglhhKDmw2PwpS34X1rYGbdudSS+daobv0NGH
         xM7ToxrbRZQMJW3eb3XpITf03W/WJezZM6BpNLuxDZEb7oOSPcREQ2o9wkAJ0ka08NB4
         XcPpgMf0//yJHvlPRbLykhHmDKQhaqBRJK784pv5t2DqharXMSmttOlR03Bp79h6XX4J
         wz8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702053122; x=1702657922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8sqOsISr4A6CIOB02HqyYbsWnQIUDQQ0cX4xtpbDCng=;
        b=KlltiDsnFn+np3XQGip6tUHkoBBf4KlO3OhMwyqDN0xRqRZLixn5RkXBkwb9f7hk0i
         PTTptdYW+DqQ4jl9K6xuavMVkfpdTxObJqekEFN/I5GBxbJNvBPcTHAQidMMrBjhkaAc
         NMUbWM29yYGUEYD9Ny+zah9w/kUrQGq6XqI5YxjOv7LLfxwAfqtF4ikAKMiS470d9/vc
         bEXanCKu6YP60yBH1sMmgn0K8LZB8TQYeqYlNXlrlSVCywwd1hKDeOUo7jhFv7t5xYR+
         BnuilUjvm3RtTPB+69lpr10yBV6K/KImJ/kc5PAM1DL/NJZrPn8mh43VtUziFDRhN8f5
         eUMQ==
X-Gm-Message-State: AOJu0Yw1glmCqOZWAshN2K3NUaLwSfbdj6UIHbEM647nAqoY9D/5bOsv
	5TYiEYcFbBHKUd1Hamw9vNFubAbxrPhbH5cm1X/8GQ==
X-Google-Smtp-Source: AGHT+IH04K90iuM9X1mkjifO4TvAKhiYyXmU1LNL55T1W04MJ1jjc5+Vy90i3bYg2jhfMs/BJZ+7n8AlC4vX1LbSMS4=
X-Received: by 2002:a05:6358:7f13:b0:170:2c2d:9d8f with SMTP id
 p19-20020a0563587f1300b001702c2d9d8fmr209508rwn.1.1702053122541; Fri, 08 Dec
 2023 08:32:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231121220155.1217090-1-iii@linux.ibm.com> <20231121220155.1217090-5-iii@linux.ibm.com>
In-Reply-To: <20231121220155.1217090-5-iii@linux.ibm.com>
From: Alexander Potapenko <glider@google.com>
Date: Fri, 8 Dec 2023 17:31:26 +0100
Message-ID: <CAG_fn=W_aH5a5grk63Uwx0Dq-dvdafAriBc3v5YtYA4cXiuJ7Q@mail.gmail.com>
Subject: Re: [PATCH v2 04/33] kmsan: Increase the maximum store size to 4096
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
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 11:07=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.co=
m> wrote:
>
> The inline assembly block in s390's chsc() stores that much.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
