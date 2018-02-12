Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180212100754.55121-15-prudo@linux.vnet.ibm.com>
References: <20180212100754.55121-1-prudo@linux.vnet.ibm.com> <20180212100754.55121-15-prudo@linux.vnet.ibm.com>
From: Philippe Ombredanne <pombredanne@nexb.com>
Date: Mon, 12 Feb 2018 11:56:25 +0100
Message-ID: <CAOFm3uFfXZZuQ6cM=pi34ybxM37BQVz08ctJmh5LryVGVgEjjA@mail.gmail.com>
Subject: Re: [PATCH 14/17] s390/kexec_file: Add kexec_file_load system call
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Philipp Rudo <prudo@linux.vnet.ibm.com>
Cc: kexec@lists.infradead.org, linux-s390@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Eric Biederman <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, Feb 12, 2018 at 11:07 AM, Philipp Rudo <prudo@linux.vnet.ibm.com> wrote:
> This patch adds the kexec_file_load system call to s390 as well as the arch
> specific functions common code requires to work. Loaders for the different
> file types will be added later.
>
> Signed-off-by: Philipp Rudo <prudo@linux.vnet.ibm.com>

<snip>

> --- /dev/null
> +++ b/arch/s390/kernel/machine_kexec_file.c
> @@ -0,0 +1,174 @@
> +/* SPDX-License-Identifier: GPL-2.0 */

I know this may sound weird but in .c files this should be instead:

// SPDX-License-Identifier: GPL-2.0

See Documentation/process/license-rules.rst for why.
-- 
Cordially
Philippe Ombredanne
