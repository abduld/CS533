Input: Image, Approximate Label
Output: Label Sgementation
-----------------------------
changed = true
do_wile changed && iterations < MAX_ITERATIONS:
  changed = false
  for ii from 0 to height:
    for jj from 0 to width:
      cp = image[ii][jj]
      nl = lp = label[ii][jj]
      ns = sp = strength[ii][jj]
      for ni from -1 to 1:
        for nj from -1 to 1:
          cq = image[ii+ni][jj+nj]
          lq = label[ii+ni][jj+nj]
          sq = strength[ii+ni][jj+nj]
          gc = g(cp, cq)
          if gc * sq > sp:
            nl = lq
            ns = sq * gc
            changed = true
          end
        end
      end
      nextLabel[ii][jj] = nl
      nextStrength[ii][jj] = ns
    end
  end
  iterations++
  label = nextLabel
  strength = nextStrength
end