Return-Path: <SRS0=sRBR=SN=vger.kernel.org=bpf-owner@kernel.org>
MIME-Version: 1.0
References: <3c15d21d2b6896e76e8801dc07de2bae1dadceb1.1554827560.git.joe@perches.com>
 <20190410181901.1e40252e@mschwideX1>
In-Reply-To: <20190410181901.1e40252e@mschwideX1>
From: Song Liu <liu.song.a23@gmail.com>
Date: Thu, 11 Apr 2019 13:48:39 -0700
Message-ID: <CAPhsuW54C34tB82-g0uzyt-pWnYh616=fR9cGT6hp5t0L5h+HA@mail.gmail.com>
Subject: Re: [PATCH 1/2] s390: Convert IS_ENABLED uses to __is_defined
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/bpf/>
List-Post: <mailto:bpf@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Joe Perches <joe@perches.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, linux-s390@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Wed, Apr 10, 2019 at 11:43 AM Martin Schwidefsky
<schwidefsky@de.ibm.com> wrote:
>
> On Tue,  9 Apr 2019 09:33:12 -0700
> Joe Perches <joe@perches.com> wrote:
>
> > IS_ENABLED should be reserved for CONFIG_<FOO> uses so convert
> > the uses of IS_ENABLED with a #define to __is_defined.
> >
> > Signed-off-by: Joe Perches <joe@perches.com>

Acked-by: Song Liu <songliubraving@fb.com>

>
> That makes a lot of sense. Added to s390/linux:features. Thanks.
>
> --
> blue skies,
>    Martin.
>
> "Reality continues to ruin my life." - Calvin.
>
