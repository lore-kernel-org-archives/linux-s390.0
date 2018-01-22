From: Heiko Carstens <heiko.carstens@de.ibm.com>
Date: Mon, 22 Jan 2018 15:11:05 +0000
Subject: Re: [man-pages PATCH 1/5] s390_runtime_instr.2: note that runtime_instr.h is not a public header
Message-Id: <20180122151105.GF4806@osiris>
In-Reply-To: <CACGkJduJ2SyWVZ7b-obLC_sB5TwHRfdpdfY5qDGrpzGgTC-H+A@mail.gmail.com>
References: <CACGkJduJ2SyWVZ7b-obLC_sB5TwHRfdpdfY5qDGrpzGgTC-H+A@mail.gmail.com>
To: linux-s390@vger.kernel.org, linux-man@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, Jan 22, 2018 at 01:11:19PM +0000, Eugene Syromyatnikov wrote:
> On Sat, Jan 20, 2018 at 11:28 AM, Heiko Carstens
> <heiko.carstens@de.ibm.com> wrote:
> > IMHO we shouldn't document the file name of a kernel header that is not
> > exported. It's name and location can change anytime. I will move the kernel
> > header file to the uapi directory where it should have been since a long
> > time.
> 
> In that case, I think it could be rephrased to something like "the
> header asm/runtime_instr.h is available for the userspace programs
> since Linux 4.15, before that it was located in
> arch/s390/include/asm/runtime_instr.h in the kernel's source tree", as
> man-pages project (as I understood) tends to reference places in
> kernel's source tree if it is deemed useful; it is usually applied to
> documentation files, however, although they also have tendency to
> migrate over time.

Yes, that's ok. However moving the header file to uapi is not going to
happen before kernel version 4.16.
