Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 21 Mar 2018 16:00:42 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 00/11] kexec_file: Clean up purgatory load
Message-Id: <20180321160042.0f7d1fe21937f37af96a982a@linux-foundation.org>
In-Reply-To: <20180321112751.22196-1-prudo@linux.vnet.ibm.com>
References: <20180321112751.22196-1-prudo@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Philipp Rudo <prudo@linux.vnet.ibm.com>
Cc: kexec@lists.infradead.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org, Dave Young <dyoung@redhat.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, Ingo Molnar <mingo@kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 21 Mar 2018 12:27:40 +0100 Philipp Rudo <prudo@linux.vnet.ibm.com> wrote:

> here is the updated patch set including Dave's comments.

There were some syntactic clashes with the "kexec_file, x86, powerpc:
refactoring for other architecutres" series.  Please check (in
linux-next) that I got it all correct and that both patch series are
functioning correctly.

I expect to send all this into Stephen for -next tomorrow.
