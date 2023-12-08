Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6A01DFF3;
	Fri,  8 Dec 2023 14:31:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EF08C433C7;
	Fri,  8 Dec 2023 14:31:01 +0000 (UTC)
Date: Fri, 8 Dec 2023 09:31:33 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Alexander Potapenko <glider@google.com>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>,
 Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>,
 Heiko Carstens <hca@linux.ibm.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Marco Elver <elver@google.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Pekka Enberg <penberg@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>,
 Vlastimil Babka <vbabka@suse.cz>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Dmitry Vyukov <dvyukov@google.com>, Hyeonggon
 Yoo <42.hyeyoo@gmail.com>, kasan-dev@googlegroups.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Mark
 Rutland <mark.rutland@arm.com>, Roman Gushchin <roman.gushchin@linux.dev>,
 Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH v2 01/33] ftrace: Unpoison ftrace_regs in
 ftrace_ops_list_func()
Message-ID: <20231208093133.62aae274@gandalf.local.home>
In-Reply-To: <CAG_fn=WHf0t=-OJL0031D+X7cX_D25G7TG0TqROsT34QcEnqsw@mail.gmail.com>
References: <20231121220155.1217090-1-iii@linux.ibm.com>
	<20231121220155.1217090-2-iii@linux.ibm.com>
	<CAG_fn=WHf0t=-OJL0031D+X7cX_D25G7TG0TqROsT34QcEnqsw@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 8 Dec 2023 15:16:10 +0100
Alexander Potapenko <glider@google.com> wrote:

> On Tue, Nov 21, 2023 at 11:02=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.=
com> wrote:
> >
> > Architectures use assembly code to initialize ftrace_regs and call
> > ftrace_ops_list_func(). Therefore, from the KMSAN's point of view,
> > ftrace_regs is poisoned on ftrace_ops_list_func entry(). This causes
> > KMSAN warnings when running the ftrace testsuite. =20
>=20
> I couldn't reproduce these warnings on x86, hope you really need this
> change on s390 :)

On x86, ftrace_regs sits on the stack. And IIUC, s390 doesn't have the same
concept of a "stack" as other architectures. Perhaps that's the reason s390
needs this?

-- Steve
