Return-Path: <SRS0=J20p=SM=vger.kernel.org=bpf-owner@kernel.org>
Date: Wed, 10 Apr 2019 18:19:01 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH 1/2] s390: Convert IS_ENABLED uses to __is_defined
In-Reply-To: <3c15d21d2b6896e76e8801dc07de2bae1dadceb1.1554827560.git.joe@perches.com>
References: <3c15d21d2b6896e76e8801dc07de2bae1dadceb1.1554827560.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190410181901.1e40252e@mschwideX1>
Sender: bpf-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/bpf/>
List-Post: <mailto:bpf@vger.kernel.org>
To: Joe Perches <joe@perches.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue,  9 Apr 2019 09:33:12 -0700
Joe Perches <joe@perches.com> wrote:

> IS_ENABLED should be reserved for CONFIG_<FOO> uses so convert
> the uses of IS_ENABLED with a #define to __is_defined.
> 
> Signed-off-by: Joe Perches <joe@perches.com>

That makes a lot of sense. Added to s390/linux:features. Thanks.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
